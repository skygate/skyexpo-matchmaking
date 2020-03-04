export class RegistrationService {
    constructor(http) {
        this.http = http;
    }

    async validateStepOfForm(data) {
        const path = `form/${data.userType}/step-${data.step}/`;

        return this.http.POST(path, data.formValues);
    }
}
