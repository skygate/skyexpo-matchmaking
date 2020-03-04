import { combineEpics, ofType } from 'redux-observable';
import { switchMap, pluck } from 'rxjs/operators';

import * as action from '../actions/registrationActions';

export function registrationEpicFactory(registrationService) {
    const validateStepOfFormEpic = action$ =>
        action$.pipe(
            ofType(action.VALIDATE_STEP_OF_FORM_REQUESTED),
            pluck('payload'),
            switchMap(({ userType, step, formValues }) =>
                registrationService
                    .validateStepOfForm({ userType, step, formValues })
                    .then(() => action.validateStepOfFormPassSuccess(userType, step))
                    .catch(response =>
                        response.code === 400
                            ? action.validateStepOfFormErrorsSuccess(response.body, userType, step)
                            : action.validateStepOfFormFail(),
                    ),
            ),
        );

    return combineEpics(validateStepOfFormEpic);
}
