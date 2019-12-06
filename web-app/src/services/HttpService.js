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

    makeRequest(method, path, data = null, type = '') {
        const formData = new FormData();
        Object.keys(data).forEach(fieldName => formData.append(fieldName, data[fieldName]));
        const params = {
            method,
            body: type === 'multipart' ? formData : JSON.stringify(data),
        };

        return fetch(BASE_URL + path, params).then(async response => {
            if (response.ok) {
                return response;
            }

            const err = new Error(response.statusText);
            err.body = await response.json();
            err.code = response.status;
            throw err;
        });
    }
}
