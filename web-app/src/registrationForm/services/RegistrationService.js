export class RegistrationService {
    constructor(http) {
        this.http = http;
    }

    async validateFirstStep(data) {
        return this.http.POST('companies/form/step-1/', data).catch(Promise.reject);
    }
}
