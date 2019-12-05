const BASE_URL = `http://localhost:8000/api/`;

export class HttpService {
    GET(path, options) {
        return this.makeRequest('GET', path, null, options);
    }

    POST(path, body, options) {
        return this.makeRequest('POST', path, body, options);
    }

    PATCH(path, body, options) {
        return this.makeRequest('PATCH', path, body, options);
    }

    DELETE(path, body, options) {
        return this.makeRequest('DELETE', path, body, options);
    }

    makeRequest(method, path, body = null, options = {}) {
        const formData = new FormData();
        for (const name in body) {
            formData.append(name, body[name]);
        }

        const params = {
            method,
            body: formData,
        };
        return fetch(BASE_URL + path, params)
            .then(async response => {
                if (response.ok) {
                    return response.json();
                }

                const err = new Error(response.statusText);
                err.body = await response.json();
                err.code = response.status;
                throw err;
            })
            .then(data => {
                return data;
            })
            .catch(error => {
                throw error;
            });
    }
}
