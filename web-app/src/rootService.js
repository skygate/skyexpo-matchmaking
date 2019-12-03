import { HttpService } from '../src/services/HttpService';
import { RegistrationService } from '../src/registrationForm/services/RegistrationService';

export const registrationService = new RegistrationService(HttpService);
