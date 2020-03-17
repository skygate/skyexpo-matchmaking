import { of, Subject } from 'rxjs';
import { ActionsObservable, StateObservable } from 'redux-observable';

import { RegistrationService } from '../services/RegistrationService';
import { registrationEpicFactory } from './registrationEpic';
import { validateRequestPayload } from '../mocks/registrationFormMocks';
import * as RegisterActions from '../actions/registrationActions';

describe('RegistrationEpics', () => {
    let registrationService;
    const mockState = new StateObservable(new Subject(), {});
    const requestPayload = { ...validateRequestPayload, isPassingFrontValidation: true };

    beforeEach(() => {
        jest.restoreAllMocks();
        registrationService = new RegistrationService();
    });

    it('Should call registration service and return success without errors', done => {
        const registrationServiceSpy = jest
            .spyOn(registrationService, 'validateStepOfForm')
            .mockImplementation(() => Promise.resolve());
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

    it('Should call registration service and return fail action for code different than 400', done => {
        const response = { code: 500 };
        const registrationServiceSpy = jest
            .spyOn(registrationService, 'validateStepOfForm')
            .mockImplementation(() => Promise.reject(response));
        const registrationEpicInstance = new registrationEpicFactory(registrationService);
        const action$ = of(RegisterActions.validateStepOfFormRequest(requestPayload));

        registrationEpicInstance(new ActionsObservable(action$), mockState, null).subscribe(
            result => {
                expect(result).toEqual(RegisterActions.validateStepOfFormFail());
                expect(registrationServiceSpy).toBeCalledWith(validateRequestPayload);

                done();
            },
        );
    });

    it('Should call registration service and return fail action for status code 400', done => {
        const nameError = { name: ' This field is required' };
        const response = {
            code: 400,
            body: nameError,
        };
        const registrationServiceSpy = jest
            .spyOn(registrationService, 'validateStepOfForm')
            .mockImplementation(() => Promise.reject(response));
        const registrationEpicInstance = new registrationEpicFactory(registrationService);
        const action$ = of(RegisterActions.validateStepOfFormRequest(requestPayload));

        registrationEpicInstance(new ActionsObservable(action$), mockState, null).subscribe(
            result => {
                expect(result).toEqual(
                    RegisterActions.validateStepOfFormErrorsFail({
                        userType: 'startup',
                        validationErrors: nameError,
                    }),
                );
                expect(registrationServiceSpy).toBeCalledWith(validateRequestPayload);

                done();
            },
        );
    });
});
