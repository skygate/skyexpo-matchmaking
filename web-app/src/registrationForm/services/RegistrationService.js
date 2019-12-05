export class RegistrationService {
    constructor(http) {
        this.http = http;
    }

    async validateFirstStep(data) {
        try {
            return await this.http.POST('companies/form/step-1/', data);
        } catch (error) {
            return Promise.reject(error);
        }
    }
}
