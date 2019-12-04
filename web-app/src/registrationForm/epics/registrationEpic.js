import { combineEpics, ofType } from 'redux-observable';
import { switchMap, pluck } from 'rxjs/operators';

import * as action from '../actions/registrationActions';

export function registrationEpicFactory(registrationService) {
    const validateFirstStepEpic = action$ =>
        action$.pipe(
            ofType(action.VALIDATE_FIRST_STEP_REQUESTED),
            pluck('payload'),
            switchMap(data =>
                registrationService
                    .validateFirstStep(data)
                    .then(action.validateFirstStepSuccess)
                    .catch(action.validateFirstStepFail),
            ),
        );

    return combineEpics(validateFirstStepEpic);
}
