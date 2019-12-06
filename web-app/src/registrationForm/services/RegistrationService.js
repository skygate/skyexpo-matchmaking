export class RegistrationService {
    constructor(http) {
        this.http = http;
    }

    async validateFirstStep(data) {
        return this.http
            .POST(`companies/form/step-${data.step}/`, data.formStep, data.type)
            .catch(Promise.reject);
    }

    async validateTeamStep(data) {
        const teamMembers = data.map((teamMember, index) => ({
            name: teamMember[`name${[index]}`],
            email: teamMember[`email${[index]}`],
        }));

        return this.http
            .POST(`companies/form/step-${data.step}/`, teamMembers, data.type)
            .catch(Promise.reject);
    }
}
