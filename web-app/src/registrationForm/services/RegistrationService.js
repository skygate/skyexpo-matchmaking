export class RegistrationService {
    constructor(http) {
        this.http = http;
    }

    async validateFirstStep() {
        try {
            return await this.http.POST('companies/form/step-1/');
        } catch (error) {
            return Promise.reject(error);
        }
    }
}
