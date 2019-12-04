import { registrationService } from '../src/rootService';

import { registrationEpicFactory } from '../src/registrationForm/epics/registrationEpic';

export const rootEpic = registrationEpicFactory(registrationService);
