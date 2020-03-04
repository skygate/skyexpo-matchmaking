export class RegistrationService {
    constructor(http) {
        this.http = http;
    }

    async validateStepOfForm(data) {
        const path = `form/${data.userType}/step-${data.step}/`;
        console.log(data.step === 1);
        return this.http.POST(path, data.formValues, { isFormData: data.step === 1 });
    }

    async saveStepFormAnswers(data) {
        const path = `profiles/${data.userType}s/`;

        return this.http.POST(path, data.formValues);
    }
}
