import { RegistrationService } from './RegistrationService';
import { HttpService } from '../../services/HttpService';
import { validateRequestPayload } from '../mocks/registrationFormMocks';

const response = { someResponse: 'someResponse' };

describe('RegistrationService', () => {
    let httpService;
    beforeEach(() => {
        jest.restoreAllMocks();
        httpService = new HttpService();
    });

    it('Should call post http service to validate form data and get response', () => {
        const httpServiceSpy = jest.spyOn(httpService, 'POST').mockImplementation(() => response);
        const registrationServiceInstance = new RegistrationService(httpService);
        const result = registrationServiceInstance.validateStepOfForm(validateRequestPayload);

        expect(result).resolves.toEqual(response);
        expect(httpServiceSpy).toHaveBeenCalledWith(
            'form/startup/step-2/',
            { name: 'testName' },
            {
                isFormData: false,
            },
        );
    });
});
