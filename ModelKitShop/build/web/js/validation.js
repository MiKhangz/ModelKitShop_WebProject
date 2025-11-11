/**
 * ModelKitShop - Form Validation
 * Client-side form validation
 */

document.addEventListener('DOMContentLoaded', function() {
    
    // Validate registration form
    const registerForm = document.getElementById('registerForm');
    if (registerForm) {
        validateRegistrationForm(registerForm);
    }
    
    // Validate login form
    const loginForm = document.getElementById('loginForm');
    if (loginForm) {
        validateLoginForm(loginForm);
    }
    
    // Validate checkout form
    const checkoutForm = document.getElementById('checkoutForm');
    if (checkoutForm) {
        validateCheckoutForm(checkoutForm);
    }
    
    // Add real-time validation to all inputs
    addRealTimeValidation();
    
});

/**
 * Validate registration form
 */
function validateRegistrationForm(form) {
    form.addEventListener('submit', function(e) {
        let isValid = true;
        const errors = [];
        
        // Username validation
        const username = form.querySelector('#username');
        if (username.value.trim().length < 3 || username.value.trim().length > 50) {
            isValid = false;
            errors.push('Username must be between 3 and 50 characters');
            markFieldInvalid(username);
        } else {
            markFieldValid(username);
        }
        
        // Email validation
        const email = form.querySelector('#email');
        if (!ModelKitShop.validateEmail(email.value)) {
            isValid = false;
            errors.push('Please enter a valid email address');
            markFieldInvalid(email);
        } else {
            markFieldValid(email);
        }
        
        // Password validation
        const password = form.querySelector('#password');
        if (password.value.length < 6) {
            isValid = false;
            errors.push('Password must be at least 6 characters');
            markFieldInvalid(password);
        } else {
            markFieldValid(password);
        }
        
        // Confirm password validation
        const confirmPassword = form.querySelector('#confirmPassword');
        if (password.value !== confirmPassword.value) {
            isValid = false;
            errors.push('Passwords do not match');
            markFieldInvalid(confirmPassword);
        } else {
            markFieldValid(confirmPassword);
        }
        
        // Full name validation
        const fullName = form.querySelector('#fullName');
        if (fullName.value.trim().length < 2) {
            isValid = false;
            errors.push('Please enter your full name');
            markFieldInvalid(fullName);
        } else {
            markFieldValid(fullName);
        }
        
        // Terms checkbox validation
        const terms = form.querySelector('#terms');
        if (!terms.checked) {
            isValid = false;
            errors.push('You must agree to the terms and conditions');
        }
        
        if (!isValid) {
            e.preventDefault();
            showValidationErrors(errors);
        }
    });
}

/**
 * Validate login form
 */
function validateLoginForm(form) {
    form.addEventListener('submit', function(e) {
        let isValid = true;
        const errors = [];
        
        // Username validation
        const username = form.querySelector('#username');
        if (username.value.trim().length === 0) {
            isValid = false;
            errors.push('Username is required');
            markFieldInvalid(username);
        } else {
            markFieldValid(username);
        }
        
        // Password validation
        const password = form.querySelector('#password');
        if (password.value.length === 0) {
            isValid = false;
            errors.push('Password is required');
            markFieldInvalid(password);
        } else {
            markFieldValid(password);
        }
        
        if (!isValid) {
            e.preventDefault();
            showValidationErrors(errors);
        }
    });
}

/**
 * Validate checkout form
 */
function validateCheckoutForm(form) {
    form.addEventListener('submit', function(e) {
        let isValid = true;
        const errors = [];
        
        // Phone validation
        const phone = form.querySelector('#phone');
        if (phone.value.trim().length > 0 && !ModelKitShop.validatePhone(phone.value)) {
            isValid = false;
            errors.push('Please enter a valid phone number');
            markFieldInvalid(phone);
        } else {
            markFieldValid(phone);
        }
        
        // Shipping address validation
        const shippingAddress = form.querySelector('#shippingAddress');
        if (shippingAddress.value.trim().length < 10) {
            isValid = false;
            errors.push('Please enter a complete shipping address');
            markFieldInvalid(shippingAddress);
        } else {
            markFieldValid(shippingAddress);
        }
        
        if (!isValid) {
            e.preventDefault();
            showValidationErrors(errors);
        }
    });
}

/**
 * Add real-time validation to all inputs
 */
function addRealTimeValidation() {
    // Email inputs
    const emailInputs = document.querySelectorAll('input[type="email"]');
    emailInputs.forEach(function(input) {
        input.addEventListener('blur', function() {
            if (input.value.length > 0 && !ModelKitShop.validateEmail(input.value)) {
                markFieldInvalid(input, 'Please enter a valid email address');
            } else {
                markFieldValid(input);
            }
        });
    });
    
    // Password confirmation
    const passwordInputs = document.querySelectorAll('input[type="password"]');
    passwordInputs.forEach(function(input) {
        if (input.id === 'confirmPassword' || input.name === 'confirmPassword') {
            input.addEventListener('input', function() {
                const password = document.querySelector('#password, input[name="password"]');
                if (password && input.value.length > 0) {
                    if (input.value !== password.value) {
                        markFieldInvalid(input, 'Passwords do not match');
                    } else {
                        markFieldValid(input);
                    }
                }
            });
        }
    });
    
    // Phone inputs
    const phoneInputs = document.querySelectorAll('input[type="tel"]');
    phoneInputs.forEach(function(input) {
        input.addEventListener('blur', function() {
            if (input.value.length > 0 && !ModelKitShop.validatePhone(input.value)) {
                markFieldInvalid(input, 'Please enter a valid phone number');
            } else {
                markFieldValid(input);
            }
        });
    });
    
    // Number inputs
    const numberInputs = document.querySelectorAll('input[type="number"]');
    numberInputs.forEach(function(input) {
        input.addEventListener('input', function() {
            const min = parseFloat(input.min);
            const max = parseFloat(input.max);
            const value = parseFloat(input.value);
            
            if (!isNaN(min) && value < min) {
                markFieldInvalid(input, `Value must be at least ${min}`);
            } else if (!isNaN(max) && value > max) {
                markFieldInvalid(input, `Value must be at most ${max}`);
            } else {
                markFieldValid(input);
            }
        });
    });
}

/**
 * Mark field as invalid
 */
function markFieldInvalid(field, message = '') {
    field.classList.add('is-invalid');
    field.classList.remove('is-valid');
    
    // Remove existing feedback
    const existingFeedback = field.parentElement.querySelector('.invalid-feedback');
    if (existingFeedback) {
        existingFeedback.remove();
    }
    
    // Add feedback message
    if (message) {
        const feedback = document.createElement('div');
        feedback.className = 'invalid-feedback';
        feedback.textContent = message;
        field.parentElement.appendChild(feedback);
    }
}

/**
 * Mark field as valid
 */
function markFieldValid(field) {
    field.classList.remove('is-invalid');
    field.classList.add('is-valid');
    
    // Remove feedback message
    const existingFeedback = field.parentElement.querySelector('.invalid-feedback');
    if (existingFeedback) {
        existingFeedback.remove();
    }
}

/**
 * Show validation errors
 */
function showValidationErrors(errors) {
    const errorHtml = `
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <i class="bi bi-exclamation-triangle"></i> 
            <strong>Validation Error:</strong>
            <ul class="mb-0 mt-2">
                ${errors.map(error => `<li>${error}</li>`).join('')}
            </ul>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    `;
    
    // Insert at the top of the form
    const form = document.querySelector('form');
    if (form) {
        form.insertAdjacentHTML('afterbegin', errorHtml);
        form.scrollIntoView({ behavior: 'smooth', block: 'start' });
    }
}

/**
 * Password strength indicator
 */
function addPasswordStrengthIndicator() {
    const passwordInputs = document.querySelectorAll('input[type="password"]#password, input[name="password"]');
    passwordInputs.forEach(function(input) {
        const indicator = document.createElement('div');
        indicator.className = 'password-strength mt-1';
        indicator.innerHTML = `
            <small class="text-muted">Password strength: <span id="strength-text">-</span></small>
            <div class="progress" style="height: 5px;">
                <div class="progress-bar" role="progressbar" style="width: 0%"></div>
            </div>
        `;
        input.parentElement.appendChild(indicator);
        
        input.addEventListener('input', function() {
            const strength = calculatePasswordStrength(input.value);
            const progressBar = indicator.querySelector('.progress-bar');
            const strengthText = indicator.querySelector('#strength-text');
            
            progressBar.style.width = strength.percentage + '%';
            progressBar.className = 'progress-bar bg-' + strength.color;
            strengthText.textContent = strength.text;
        });
    });
}

/**
 * Calculate password strength
 */
function calculatePasswordStrength(password) {
    let strength = 0;
    
    if (password.length >= 6) strength += 20;
    if (password.length >= 10) strength += 20;
    if (/[a-z]/.test(password)) strength += 20;
    if (/[A-Z]/.test(password)) strength += 20;
    if (/[0-9]/.test(password)) strength += 10;
    if (/[^a-zA-Z0-9]/.test(password)) strength += 10;
    
    let text, color;
    if (strength < 40) {
        text = 'Weak';
        color = 'danger';
    } else if (strength < 70) {
        text = 'Medium';
        color = 'warning';
    } else {
        text = 'Strong';
        color = 'success';
    }
    
    return { percentage: strength, text, color };
}

// Initialize password strength indicator
document.addEventListener('DOMContentLoaded', addPasswordStrengthIndicator);
