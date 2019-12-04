import { HttpService } from '../src/services/HttpService';
import { RegistrationService } from '../src/registrationForm/services/RegistrationService';

export const httpService = new HttpService();
export const registrationService = new RegistrationService(httpService);
