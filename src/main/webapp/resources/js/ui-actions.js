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

}