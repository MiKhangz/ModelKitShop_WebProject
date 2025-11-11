package Controller;


import java.awt.*;
import java.awt.font.FontRenderContext;
import java.awt.font.LineBreakMeasurer;
import java.awt.font.TextAttribute;
import java.awt.geom.Rectangle2D;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.OutputStream;
import java.text.AttributedString;
import java.util.Random;

import javax.imageio.ImageIO;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
/*
Ghi chú:
+Mấy ông thủ xài doPost để chạy nha, giống hướng dẫn processRequest của Thầy
+Kiểu này tách nhỏ ra dễ fix hơn
+Để lúc tui ghép code tụi mình lại, tui đỡ phải mò
+Ví dụ như LoginServlet tui viết
   
From Khang
*/
@WebServlet(name = "ProductImageServlet", urlPatterns = {"/image/product"})
public class ProductImageServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Params
        String idStr = request.getParameter("id");
        String name = paramOrDefault(request.getParameter("name"), "Model Kit");
        String brand = request.getParameter("brand");
        String scale = request.getParameter("scale");
        int width = parseOrDefault(request.getParameter("w"), 600);
        int height = parseOrDefault(request.getParameter("h"), 600);

        // Seed color by id if present
        long seed = (name + (brand == null ? "" : brand) + (scale == null ? "" : scale)).hashCode();
        try {
            if (idStr != null) seed = Long.parseLong(idStr);
        } catch (NumberFormatException ignored) {}

        BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
        Graphics2D g = image.createGraphics();
        try {
            g.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
            g.setRenderingHint(RenderingHints.KEY_TEXT_ANTIALIASING, RenderingHints.VALUE_TEXT_ANTIALIAS_ON);

            // Background gradient
            Color[] palette = paletteFromSeed(seed);
            GradientPaint gp = new GradientPaint(0, 0, palette[0], width, height, palette[1]);
            g.setPaint(gp);
            g.fillRect(0, 0, width, height);

            // Card-like inset
            int pad = Math.max(16, Math.min(width, height) / 20);
            g.setColor(new Color(255, 255, 255, 60));
            g.fillRoundRect(pad, pad, width - 2 * pad, height - 2 * pad, 24, 24);

            // Draw text: name (wrap), brand/scale
            int innerW = width - 2 * pad - 24;
            int innerLeft = pad + 12;
            int textTop = pad + 24;

            // Title font size adaptive
            int titleSize = Math.max(20, Math.min(40, innerW / 12));
            Font titleFont = new Font("SansSerif", Font.BOLD, titleSize);
            g.setColor(Color.WHITE);
            drawWrappedCentered(g, name, titleFont, innerLeft, textTop, innerW, height / 2);

            // Subtitle
            String sub = buildSubtitle(brand, scale);
            if (!sub.isEmpty()) {
                Font subFont = new Font("SansSerif", Font.PLAIN, Math.max(14, titleSize - 8));
                int subY = height - pad - 24;
                drawCentered(g, sub, subFont, width / 2, subY);
            }

            // Watermark
            g.setColor(new Color(255, 255, 255, 90));
            Font wm = new Font("SansSerif", Font.PLAIN, 14);
            String watermark = "ModelKitShop";
            Rectangle2D bounds = g.getFontMetrics(wm).getStringBounds(watermark, g);
            g.setFont(wm);
            g.drawString(watermark, width - pad - (int) bounds.getWidth(), height - pad);

        } finally {
            g.dispose();
        }

        response.setContentType("image/png");
        // Cache headers (1 day)
        response.setHeader("Cache-Control", "public, max-age=86400");
        try (OutputStream os = response.getOutputStream()) {
            ImageIO.write(image, "png", os);
        }
    }

    private static String paramOrDefault(String s, String def) {
        return (s == null || s.trim().isEmpty()) ? def : s.trim();
    }

    private static int parseOrDefault(String s, int def) {
        try { return Integer.parseInt(s); } catch (Exception e) { return def; }
    }

    private static String buildSubtitle(String brand, String scale) {
        StringBuilder sb = new StringBuilder();
        if (brand != null && !brand.isEmpty()) sb.append(brand.trim());
        if (scale != null && !scale.isEmpty()) { 
            if (sb.length() > 0) sb.append("  •  ");
            sb.append(scale.trim());
        }
        return sb.toString();
    }

    private static Color[] paletteFromSeed(long seed) {
        Random r = new Random(seed);
        float h1 = r.nextFloat();
        float h2 = (h1 + 0.15f + r.nextFloat() * 0.2f) % 1f;
        Color c1 = Color.getHSBColor(h1, 0.6f + r.nextFloat() * 0.3f, 0.7f + r.nextFloat() * 0.3f);
        Color c2 = Color.getHSBColor(h2, 0.5f + r.nextFloat() * 0.4f, 0.6f + r.nextFloat() * 0.4f);
        return new Color[]{c1, c2};
    }

    private static void drawCentered(Graphics2D g, String text, Font font, int centerX, int baselineY) {
        g.setFont(font);
        Rectangle2D rect = g.getFontMetrics().getStringBounds(text, g);
        int x = (int) (centerX - rect.getWidth() / 2);
        g.drawString(text, x, baselineY);
    }

    private static void drawWrappedCentered(Graphics2D g, String text, Font font, int x, int y, int maxWidth, int maxHeight) {
        AttributedString attStr = new AttributedString(text);
        attStr.addAttribute(TextAttribute.FONT, font);
        FontRenderContext frc = g.getFontRenderContext();
        LineBreakMeasurer measurer = new LineBreakMeasurer(attStr.getIterator(), frc);

        int lineHeight = g.getFontMetrics(font).getHeight();
        int usedH = 0;
        while (measurer.getPosition() < text.length() && usedH + lineHeight <= maxHeight) {
            int next = measurer.nextOffset(maxWidth);
            String line = text.substring(measurer.getPosition(), next);
            Rectangle2D rect = g.getFontMetrics(font).getStringBounds(line, g);
            int drawX = (int) (x + (maxWidth - rect.getWidth()) / 2);
            int drawY = y + usedH + g.getFontMetrics(font).getAscent();
            g.drawString(line, drawX, drawY);
            usedH += lineHeight;
            measurer.setPosition(next);
        }
    }
}
