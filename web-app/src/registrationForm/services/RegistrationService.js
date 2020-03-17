export class RegistrationService {
    constructor(http) {
        this.http = http;
    }

    async validateStepOfForm(data) {
        const path = `form/${data.userType}/step-${data.step + 1}/`;
        //We use formData because in first step we have image and it is faster to send it in formData
        const isFormData = data.step === 0;

        return this.http.POST(path, data.formValues, {
            isFormData,
        });
    }

    async saveStepFormAnswers(data) {
        const path = `profiles/${data.userType}s/`;

        return this.http.POST(path, data.formValues);
    }
}
