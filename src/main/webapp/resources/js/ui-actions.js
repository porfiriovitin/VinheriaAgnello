/**
 * ui-actions.js
 * Contains all global UI functions triggered by user interactions.
 * Note: This file requires ApiClient to be loaded first.
 */

async function addToFavorites(productId) {
    try {
        const responseData = await ApiClient.request('AddFavorite', { id: productId });

        if (responseData.status === 'success') {
            // :: Find the specific span that was clicked
            const icon = document.getElementById(`fav-icon-${productId}`);

            // :: Update visual state to "Favorited" (Red and filled)
            icon.classList.remove('text-primary/30', 'group-hover:text-primary');
            icon.classList.add('text-red-500');
            icon.style.fontVariationSettings = "'FILL' 1";

            // :: Change the click event to trigger the Remove function
            icon.setAttribute('onclick', `removeFromFavorites(${productId})`);

        }

    } catch (error) {
        console.error('Failed to add favorite:', error);
        alert('Could not add item to favorites. Please try again.');
    }
}

async function removeFromFavorites(productId) {
    try {
        const responseData = await ApiClient.request('RemoveFavorite', { id: productId });

        if (responseData.status === 'success') {
            // :: Find the specific span that was clicked
            const icon = document.getElementById(`fav-icon-${productId}`);

            // :: Revert visual state to "Not Favorited" (Faded and hollow)
            icon.classList.remove('text-red-500');
            icon.classList.add('text-primary/30', 'group-hover:text-primary');
            icon.style.fontVariationSettings = "'FILL' 0";

            // :: Change the click event to trigger the Remove function
            icon.setAttribute('onclick', `addToFavorites(${productId})`);
        }

    } catch (error) {
        console.error('Failed to remove favorite:', error);
        alert('Could not remove item from favorites. Please try again.');
    }
}

// Example of how easy it is to add a new shared function in the future
async function addToCart(productId, quantity) {
    const wineId = String(productId || '').trim();
    if (!wineId) return;

    const safeQuantity = Number.isFinite(Number(quantity)) && Number(quantity) > 0 ? Number(quantity) : 1;

    try {
        const responseData = await sendCartAction('AddToCart', { wines: [{ id: wineId, quantity: safeQuantity }] });
        if (responseData.cart) {
            applyCartState(responseData.cart);
        }
    } catch (error) {
        console.error('Failed to add item to cart:', error);
        alert(error.message || 'Não foi possível adicionar o item ao carrinho.');
    }
}

async function sendCartAction(action, cartItems) {
<<<<<<< HEAD
    const data = await ApiClient.request(action, {}, 'POST', { CartItems: cartItems });
    if (data.redirected) {
        return data;
=======
    const baseUrl = (window.ApiClient && ApiClient.BASE_URL) ? ApiClient.BASE_URL : `${window.APP_CONTEXT || ''}/controller`;
    const url = `${baseUrl}?action=${encodeURIComponent(action)}`;

    const response = await fetch(url, {
        method: 'POST',
        headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ CartItems: cartItems })
    });

    let data = {};
    try {
        data = await response.json();
    } catch (error) {
        throw new Error('Resposta inválida do servidor.');
>>>>>>> update
    }
    if (data.status !== 'success') {
        throw new Error(data.message || 'Resposta inválida do servidor.');
    }

    return data;
}

const currencyFormatter = new Intl.NumberFormat('pt-BR', {
    minimumFractionDigits: 2,
    maximumFractionDigits: 2
});

let checkoutBusy = false;

function safeNumber(value) {
    const parsed = Number(value);
    return Number.isFinite(parsed) ? parsed : 0;
}

function formatCurrencyValue(value) {
    return currencyFormatter.format(safeNumber(value));
}

function escapeHtml(value) {
    const text = (value ?? '').toString();
    return text
        .replaceAll('&', '&amp;')
        .replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;')
        .replaceAll('"', '&quot;')
        .replaceAll("'", '&#39;');
}

function renderWineItems(wines) {
    const container = document.getElementById('wine-items-container');
    if (!container) return;

    if (!Array.isArray(wines) || wines.length === 0) {
        container.innerHTML = `
            <div class="bg-white dark:bg-primary/5 p-4 rounded-xl border border-primary/10 flex items-center justify-between gap-4">
                <p class="text-sm text-slate-600 dark:text-slate-300">Nenhum vinho adicionado ao carrinho.</p>
                <a href="${window.APP_CONTEXT || ''}/controller?action=ShowCatalog"
                   class="inline-flex items-center justify-center rounded-lg bg-primary hover:bg-primary/90 px-4 py-2 text-xs font-bold uppercase tracking-wider text-white transition-colors shrink-0">
                    Ver Catálogo
                </a>
            </div>
        `;
        return;
    }

    container.innerHTML = wines.map((item) => {
        const wineId = escapeHtml(item.id);
        const imageUrl = escapeHtml(item.imageUrl);
        const name = escapeHtml(item.name);
        const region = escapeHtml(item.region);
        const country = escapeHtml(item.country);
        const price = formatCurrencyValue(item.price);
        const quantity = Math.max(1, safeNumber(item.quantity));

        return `
            <div class="js-wine-item flex items-center gap-4 bg-white dark:bg-primary/5 p-3 rounded-xl border border-primary/5 shadow-sm" data-wine-id="${wineId}">
                <div class="bg-center bg-no-repeat aspect-square bg-cover rounded-lg size-20 shrink-0" style="background-image: url('${imageUrl}');"></div>
                <div class="flex flex-col flex-1 min-w-0">
                    <p class="text-slate-900 dark:text-slate-100 font-display font-medium text-base leading-tight line-clamp-1">${name}</p>
                    <p class="text-primary/70 text-sm font-normal mb-2">${region}, ${country}</p>
                    <div class="flex items-center justify-between">
                        <p class="text-primary font-bold">R$ ${price}</p>
                        <div class="flex items-center gap-3 bg-primary/5 rounded-full px-2 py-1">
                            <button class="js-wine-remove text-primary hover:bg-primary/10 rounded-full w-6 h-6 flex items-center justify-center" data-wine-id="${wineId}" type="button">-</button>
                            <span class="js-wine-qty text-sm font-bold w-4 text-center">${quantity}</span>
                            <button class="js-wine-add text-primary hover:bg-primary/10 rounded-full w-6 h-6 flex items-center justify-center" data-wine-id="${wineId}" type="button">+</button>
                        </div>
                    </div>
                </div>
            </div>
        `;
    }).join('');
}

function updateAccessoriesUI(cartAccessories) {
    const selectedIds = new Set((cartAccessories || []).map((item) => String(item.id)));
    const accessoryButtons = document.querySelectorAll('.js-accessory-toggle');

    accessoryButtons.forEach((button) => {
        const accessoryId = button.dataset.accessoryId;
        const inCart = selectedIds.has(String(accessoryId));

        button.dataset.inCart = String(inCart);
        button.textContent = inCart ? 'Adicionado' : 'Adicionar';
        button.classList.toggle('bg-white', inCart);
        button.classList.toggle('text-green-600', inCart);
        button.classList.toggle('border-green-600', inCart);
        button.classList.toggle('bg-primary', !inCart);
        button.classList.toggle('text-white', !inCart);
        button.classList.toggle('border-transparent', !inCart);
    });
}

function updateGiftUI(gifts) {
    const giftCheckbox = document.getElementById('is_gift');
    const giftMessage = document.getElementById('gift-letter-text');
    const giftPriceLabel = document.getElementById('gift-price-value');
    const currentGift = Array.isArray(gifts) && gifts.length ? gifts[0] : null;

    if (giftCheckbox) {
        giftCheckbox.checked = Boolean(currentGift && currentGift.applied);
        if (currentGift && currentGift.id) {
            giftCheckbox.dataset.giftId = currentGift.id;
        }
        if (currentGift && currentGift.price != null) {
            giftCheckbox.dataset.giftPrice = String(currentGift.price);
        }
    }

    if (giftMessage) {
        giftMessage.value = currentGift?.letterText || '';
    }

    if (giftPriceLabel) {
        const rawBaseGiftPrice = giftCheckbox?.dataset?.giftPrice;
        const hasBaseGiftPrice = typeof rawBaseGiftPrice === 'string' && rawBaseGiftPrice.trim() !== '';
        const visibleGiftPrice = currentGift && currentGift.price != null
            ? safeNumber(currentGift.price)
            : hasBaseGiftPrice
                ? safeNumber(rawBaseGiftPrice)
                : null;
        if (visibleGiftPrice == null) return;
        giftPriceLabel.textContent = formatCurrencyValue(visibleGiftPrice);
    }
}

function updateTotalUI(cart) {
    const totalElement = document.getElementById('cart-total-value');
    const strikeTotalElement = document.getElementById('cart-total-strikethrough-value');
    if (!totalElement) return;

    const winesTotal = (cart.wines || []).reduce((sum, wine) => {
        return sum + (safeNumber(wine.price) * Math.max(1, safeNumber(wine.quantity)));
    }, 0);

    const accessoriesTotal = (cart.accessories || []).reduce((sum, accessory) => {
        return sum + (safeNumber(accessory.price) * Math.max(1, safeNumber(accessory.quantity)));
    }, 0);

    const gift = (cart.gifts || [])[0];
    const giftTotal = gift && gift.applied ? safeNumber(gift.price) : 0;

    const totalFormatted = formatCurrencyValue(winesTotal + accessoriesTotal + giftTotal);
    totalElement.textContent = totalFormatted;
    if (strikeTotalElement) {
        strikeTotalElement.textContent = totalFormatted;
    }
}

function applyCartState(cart) {
    if (!cart) return;
    renderWineItems(cart.wines || []);
    updateAccessoriesUI(cart.accessories || []);
    updateGiftUI(cart.gifts || []);
    updateTotalUI(cart);
}

async function handleWineAdd(wineId) {
    const responseData = await sendCartAction('AddToCart', { wines: [{ id: wineId, quantity: 1 }] });
    applyCartState(responseData.cart);
}

async function handleWineRemove(wineId) {
    const responseData = await sendCartAction('RemoveFromCart', { wines: [{ id: wineId, quantity: 1 }] });
    applyCartState(responseData.cart);
}

async function handleAccessoryToggle(button) {
    const accessoryId = button.dataset.accessoryId;
    const isInCart = button.dataset.inCart === 'true';

    if (!accessoryId) return;

    if (isInCart) {
        const responseData = await sendCartAction('RemoveFromCart', { accessories: [{ id: accessoryId, quantity: 1 }] });
        applyCartState(responseData.cart);
    } else {
        const responseData = await sendCartAction('AddToCart', { accessories: [{ id: accessoryId, quantity: 1 }] });
        applyCartState(responseData.cart);
    }
}

async function handleGiftToggle(checkbox, messageField) {
    const giftId = checkbox.dataset.giftId;
    if (!giftId) {
        checkbox.checked = false;
        alert('Não foi possível identificar o presente.');
        return;
    }

    if (checkbox.checked) {
        const responseData = await sendCartAction('AddToCart', {
            gifts: [{ id: giftId, applied: true, letterText: messageField ? messageField.value : '' }]
        });
        applyCartState(responseData.cart);
    } else {
        const responseData = await sendCartAction('RemoveFromCart', {
            gifts: [{ id: giftId }]
        });
        applyCartState(responseData.cart);
    }
}

async function handleGiftLetterUpdate(checkbox, messageField) {
    if (!checkbox.checked) return;

    const giftId = checkbox.dataset.giftId;
    if (!giftId) return;

    const responseData = await sendCartAction('AddToCart', {
        gifts: [{ id: giftId, applied: true, letterText: messageField.value }]
    });
    applyCartState(responseData.cart);
}

(function initCheckoutPageActions() {
    document.addEventListener('DOMContentLoaded', function () {
        const giftCheckbox = document.getElementById('is_gift');
        const giftMessage = document.getElementById('gift-letter-text');

        if (!document.querySelector('.js-wine-add') && !document.querySelector('.js-wine-remove') && !document.querySelector('.js-accessory-toggle') && !giftCheckbox) {
            return;
        }

        document.addEventListener('click', async (event) => {
            const addButton = event.target.closest('.js-wine-add');
            const removeButton = event.target.closest('.js-wine-remove');
            const accessoryButton = event.target.closest('.js-accessory-toggle');

            if (!addButton && !removeButton && !accessoryButton) return;
            if (checkoutBusy) return;

            checkoutBusy = true;
            const clickedButton = addButton || removeButton || accessoryButton;
            if (clickedButton) clickedButton.disabled = true;

            try {
                if (addButton) {
                    await handleWineAdd(addButton.dataset.wineId);
                } else if (removeButton) {
                    await handleWineRemove(removeButton.dataset.wineId);
                } else if (accessoryButton) {
                    await handleAccessoryToggle(accessoryButton);
                }
            } catch (error) {
                console.error('Failed to update cart:', error);
                alert(error.message || 'Não foi possível atualizar o carrinho.');
            } finally {
                checkoutBusy = false;
                if (clickedButton) clickedButton.disabled = false;
            }
        });

        if (giftCheckbox) {
            giftCheckbox.addEventListener('change', async () => {
                if (checkoutBusy) return;
                checkoutBusy = true;
                giftCheckbox.disabled = true;
                if (giftMessage) giftMessage.disabled = true;
                try {
                    await handleGiftToggle(giftCheckbox, giftMessage);
                } catch (error) {
                    console.error('Failed to toggle gift in cart:', error);
                    giftCheckbox.checked = !giftCheckbox.checked;
                    alert(error.message || 'Não foi possível atualizar o presente.');
                } finally {
                    checkoutBusy = false;
                    giftCheckbox.disabled = false;
                    if (giftMessage) giftMessage.disabled = false;
                }
            });
        }

        if (giftCheckbox && giftMessage) {
            giftMessage.addEventListener('blur', async () => {
                if (checkoutBusy) return;
                checkoutBusy = true;
                try {
                    await handleGiftLetterUpdate(giftCheckbox, giftMessage);
                } catch (error) {
                    console.error('Failed to update gift letter text:', error);
                    alert(error.message || 'Não foi possível atualizar a mensagem do presente.');
                } finally {
                    checkoutBusy = false;
                }
            });
        }
    });
})();

(function initProductDetailsActions() {
    document.addEventListener('DOMContentLoaded', function () {
        const addToCartButton = document.querySelector('.js-product-add-to-cart');
        const addToCartLabel = addToCartButton?.querySelector('.js-product-add-to-cart-label');
        const addToCartIcon = addToCartButton?.querySelector('.material-symbols-outlined');
        if (!addToCartButton) return;

        const setAddedVisualState = () => {
            addToCartButton.classList.remove('bg-primary', 'text-white', 'border-transparent', 'shadow-primary/20');
            addToCartButton.classList.add('bg-white', 'text-primary', 'border-primary');
            addToCartButton.dataset.added = 'true';
            if (addToCartLabel) {
                addToCartLabel.textContent = 'Ver Carrinho';
            }
            if (addToCartIcon) {
                addToCartIcon.textContent = 'shopping_cart';
            }
        };

        addToCartButton.addEventListener('click', async () => {
            if (addToCartButton.disabled) return;
            if (addToCartButton.dataset.added === 'true') {
<<<<<<< HEAD
                window.location.href = window.location.pathname + '?action=ShowCartCheckout';
=======
                window.location.href = `${window.APP_CONTEXT || ''}/controller?action=ShowCartCheckout`;
>>>>>>> update
                return;
            }

            const wineId = addToCartButton.dataset.wineId;
            if (!wineId) {
                alert('Não foi possível identificar o vinho.');
                return;
            }

            addToCartButton.disabled = true;
            try {
                await addToCart(wineId, 1);
                setAddedVisualState();
            } finally {
                addToCartButton.disabled = false;
            }
        });
    });
})();
