import { of, Subject } from 'rxjs';
import { ActionsObservable, StateObservable } from 'redux-observable';

import { RegistrationService } from '../services/RegistrationService';
import { registrationEpicFactory } from './registrationEpic';
import { validateRequestPayload } from '../mocks/registrationFormMocks';
import * as RegisterActions from '../actions/registrationActions';

const response = { someResponse: 'someResponse' };

describe('RegistrationEpics', () => {
    let registrationService;
    const mockState = new StateObservable(new Subject(), {});

    beforeEach(() => {
        jest.restoreAllMocks();
        registrationService = new RegistrationService();
    });

    it('Should call registration service and return success without errors', done => {
        const requestPayload = { ...validateRequestPayload, isPassingFrontValidation: true };
        const registrationServiceSpy = jest
            .spyOn(registrationService, 'validateStepOfForm')
            .mockImplementation(() => Promise.resolve(response));
        const registrationEpicInstance = new registrationEpicFactory(registrationService);
        const action$ = of(RegisterActions.validateStepOfFormRequest(requestPayload));

        registrationEpicInstance(new ActionsObservable(action$), mockState, null).subscribe(
            result => {
                expect(result).toEqual(
                    RegisterActions.validateStepOfFormPassSuccess({
                        isPassingFrontValidation: true,
                        userType: 'startup',
                    }),
                );
                expect(registrationServiceSpy).toBeCalledWith(validateRequestPayload);

                done();
            },
        );
    });
});
