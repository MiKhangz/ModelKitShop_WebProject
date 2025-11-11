/**
 * ModelKitShop - Shopping Cart
 * Cart functionality and calculations
 */

document.addEventListener('DOMContentLoaded', function() {
    
    // Initialize cart
    initializeCart();
    
    // Update cart totals
    updateCartTotals();
    
    // Add quantity controls
    addQuantityControls();
    
});

/**
 * Initialize cart functionality
 */
function initializeCart() {
    // Add event listeners to quantity inputs
    const quantityInputs = document.querySelectorAll('input[name="quantity"]');
    quantityInputs.forEach(function(input) {
        input.addEventListener('change', function() {
            validateQuantity(this);
        });
    });
    
    // Add event listeners to remove buttons
    const removeButtons = document.querySelectorAll('button[data-action="remove"]');
    removeButtons.forEach(function(button) {
        button.addEventListener('click', function(e) {
            if (!confirm('Remove this item from cart?')) {
                e.preventDefault();
            }
        });
    });
}

/**
 * Update cart totals
 */
function updateCartTotals() {
    const cartItems = document.querySelectorAll('.cart-item');
    let subtotal = 0;
    let itemCount = 0;
    
    cartItems.forEach(function(item) {
        const price = parseFloat(item.dataset.price || 0);
        const quantity = parseInt(item.querySelector('input[name="quantity"]')?.value || 0);
        const itemTotal = price * quantity;
        
        subtotal += itemTotal;
        itemCount += quantity;
        
        // Update item subtotal display
        const subtotalElement = item.querySelector('.item-subtotal');
        if (subtotalElement) {
            subtotalElement.textContent = ModelKitShop.formatCurrency(itemTotal);
        }
    });
    
    // Update cart summary
    updateCartSummary(subtotal, itemCount);
}

/**
 * Update cart summary
 */
function updateCartSummary(subtotal, itemCount) {
    // Update subtotal
    const subtotalElement = document.querySelector('.cart-subtotal');
    if (subtotalElement) {
        subtotalElement.textContent = ModelKitShop.formatCurrency(subtotal);
    }
    
    // Calculate shipping
    const shipping = subtotal >= 50 ? 0 : 5;
    const shippingElement = document.querySelector('.cart-shipping');
    if (shippingElement) {
        shippingElement.textContent = shipping === 0 ? 'FREE' : ModelKitShop.formatCurrency(shipping);
    }
    
    // Calculate total
    const total = subtotal + shipping;
    const totalElement = document.querySelector('.cart-total');
    if (totalElement) {
        totalElement.textContent = ModelKitShop.formatCurrency(total);
    }
    
    // Update item count
    const itemCountElement = document.querySelector('.cart-item-count');
    if (itemCountElement) {
        itemCountElement.textContent = itemCount;
    }
    
    // Update navbar cart badge
    updateCartBadge(itemCount);
}

/**
 * Update cart badge in navbar
 */
function updateCartBadge(count) {
    const badge = document.querySelector('.cart-badge');
    if (badge) {
        badge.textContent = count;
        if (count > 0) {
            badge.style.display = 'inline-block';
        } else {
            badge.style.display = 'none';
        }
    }
}

/**
 * Validate quantity input
 */
function validateQuantity(input) {
    const min = parseInt(input.min || 1);
    const max = parseInt(input.max || 999);
    let value = parseInt(input.value);
    
    if (isNaN(value) || value < min) {
        input.value = min;
        ModelKitShop.showNotification('Quantity must be at least ' + min, 'warning');
    } else if (value > max) {
        input.value = max;
        ModelKitShop.showNotification('Maximum quantity is ' + max, 'warning');
    }
    
    updateCartTotals();
}

/**
 * Add quantity increment/decrement controls
 */
function addQuantityControls() {
    const quantityInputs = document.querySelectorAll('input[name="quantity"]');
    
    quantityInputs.forEach(function(input) {
        const wrapper = document.createElement('div');
        wrapper.className = 'input-group';
        
        // Create decrement button
        const decrementBtn = document.createElement('button');
        decrementBtn.className = 'btn btn-outline-secondary';
        decrementBtn.type = 'button';
        decrementBtn.innerHTML = '<i class="bi bi-dash"></i>';
        decrementBtn.addEventListener('click', function() {
            const currentValue = parseInt(input.value);
            const minValue = parseInt(input.min || 1);
            if (currentValue > minValue) {
                input.value = currentValue - 1;
                validateQuantity(input);
            }
        });
        
        // Create increment button
        const incrementBtn = document.createElement('button');
        incrementBtn.className = 'btn btn-outline-secondary';
        incrementBtn.type = 'button';
        incrementBtn.innerHTML = '<i class="bi bi-plus"></i>';
        incrementBtn.addEventListener('click', function() {
            const currentValue = parseInt(input.value);
            const maxValue = parseInt(input.max || 999);
            if (currentValue < maxValue) {
                input.value = currentValue + 1;
                validateQuantity(input);
            }
        });
        
        // Wrap input with controls
        input.parentNode.insertBefore(wrapper, input);
        wrapper.appendChild(decrementBtn);
        wrapper.appendChild(input);
        wrapper.appendChild(incrementBtn);
    });
}

/**
 * Add to cart (AJAX)
 */
async function addToCart(productId, quantity = 1) {
    try {
        ModelKitShop.showLoading('Adding to cart...');
        
        const formData = new FormData();
        formData.append('action', 'add');
        formData.append('productId', productId);
        formData.append('quantity', quantity);
        
        const response = await fetch('/ModelKitShop/cart', {
            method: 'POST',
            body: formData
        });
        
        if (response.ok) {
            ModelKitShop.hideLoading();
            ModelKitShop.showNotification('Product added to cart!', 'success');
            
            // Optionally refresh cart
            // location.reload();
        } else {
            throw new Error('Failed to add to cart');
        }
    } catch (error) {
        ModelKitShop.hideLoading();
        ModelKitShop.showNotification('Error adding product to cart', 'danger');
        console.error('Add to cart error:', error);
    }
}

/**
 * Update cart item (AJAX)
 */
async function updateCartItem(productId, quantity) {
    try {
        const formData = new FormData();
        formData.append('action', 'update');
        formData.append('productId', productId);
        formData.append('quantity', quantity);
        
        const response = await fetch('/ModelKitShop/cart', {
            method: 'POST',
            body: formData
        });
        
        if (response.ok) {
            ModelKitShop.showNotification('Cart updated!', 'success');
            updateCartTotals();
        } else {
            throw new Error('Failed to update cart');
        }
    } catch (error) {
        ModelKitShop.showNotification('Error updating cart', 'danger');
        console.error('Update cart error:', error);
    }
}

/**
 * Remove from cart (AJAX)
 */
async function removeFromCart(productId) {
    if (!confirm('Remove this item from cart?')) {
        return;
    }
    
    try {
        ModelKitShop.showLoading('Removing item...');
        
        const formData = new FormData();
        formData.append('action', 'remove');
        formData.append('productId', productId);
        
        const response = await fetch('/ModelKitShop/cart', {
            method: 'POST',
            body: formData
        });
        
        if (response.ok) {
            ModelKitShop.hideLoading();
            ModelKitShop.showNotification('Item removed from cart', 'info');
            location.reload();
        } else {
            throw new Error('Failed to remove from cart');
        }
    } catch (error) {
        ModelKitShop.hideLoading();
        ModelKitShop.showNotification('Error removing item from cart', 'danger');
        console.error('Remove from cart error:', error);
    }
}

/**
 * Calculate discount
 */
function calculateDiscount(originalPrice, discountedPrice) {
    const discount = ((originalPrice - discountedPrice) / originalPrice) * 100;
    return Math.round(discount);
}

/**
 * Apply coupon code
 */
async function applyCoupon(code) {
    try {
        ModelKitShop.showLoading('Applying coupon...');
        
        // API call to validate and apply coupon
        // const response = await fetch('/ModelKitShop/cart/coupon', {...});
        
        ModelKitShop.hideLoading();
        ModelKitShop.showNotification('Coupon applied successfully!', 'success');
        updateCartTotals();
    } catch (error) {
        ModelKitShop.hideLoading();
        ModelKitShop.showNotification('Invalid coupon code', 'danger');
    }
}

// Export functions
window.CartManager = {
    addToCart,
    updateCartItem,
    removeFromCart,
    calculateDiscount,
    applyCoupon
};
