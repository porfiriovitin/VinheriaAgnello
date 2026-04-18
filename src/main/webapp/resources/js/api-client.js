class ApiClient {

    // The base endpoint pointing to DispatcherServlet
    static BASE_URL = `${window.APP_CONTEXT || ''}/controller`;

    /**
     * Executes an HTTP request to the Front Controller.
     * * @param {string} action - The action name (e.g., 'AddFavorite').
     * @param {object} params - Key-value pairs of data (e.g., { id: 15 }).
     * @param {string} method - The HTTP method ('GET', 'POST', etc.). Defaults to 'GET'.
     * @returns {Promise<object>} The parsed JSON response.
     */
    static async request(action, params = {}, method = 'GET', body = null) {

        // 1. Automatically build the query string (e.g., action=AddFavorite&id=15)
        const queryData = { action: action, ...params };
        const queryString = new URLSearchParams(queryData).toString();
        const url = `${this.BASE_URL}?${queryString}`;

        // 2. Configure the standard headers
        const config = {
            method: method,
            headers: { 'Accept': 'application/json' }
        };

        if (body !== null) {
            config.headers['Content-Type'] = 'application/json';
            config.body = JSON.stringify(body);
        }

        try {
            // 3. Execute the fetch call
            const response = await fetch(url, config);

            // Some actions may intentionally redirect (e.g., session timeout/login).
            // In this case, avoid JSON parsing/errors and let browser continue.
            if (response.redirected) {
                window.location.href = response.url;
                return {
                    status: 'redirected',
                    redirected: true,
                    url: response.url
                };
            }

            const data = await response.json();

            // 4. Centralized Error Handling
            // If the Java backend sends a 400 or 500 status code, it falls here
            if (!response.ok) {
                const errorMessage = data.message || `HTTP Error: ${response.status}`;
                throw new Error(errorMessage);
            }

            // 5. Return only the clean data payload on success
            return data;

        } catch (error) {
            console.error(`[ApiClient Error] Action: ${action} |`, error);
            throw error; // Rethrow so the specific UI component can show an alert if needed
        }
    }
}
