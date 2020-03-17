import { combineEpics, ofType } from 'redux-observable';
import { switchMap, pluck } from 'rxjs/operators';

import * as action from '../actions/registrationActions';

export function registrationEpicFactory(registrationService) {
    const validateStepOfFormEpic = action$ =>
        action$.pipe(
            ofType(action.VALIDATE_STEP_OF_FORM_REQUESTED),
            pluck('payload'),
            switchMap(({ userType, step, formValues, isPassingFrontValidation }) =>
                registrationService
                    .validateStepOfForm({ userType, step, formValues })
                    .then(() =>
                        action.validateStepOfFormPassSuccess({
                            userType,
                            isPassingFrontValidation,
                        }),
                    )
                    .catch(response =>
                        response.code === 400
                            ? action.validateStepOfFormErrorsFail({
                                  validationErrors: response.body,
                                  userType,
                              })
                            : action.validateStepOfFormFail(),
                    ),
            ),
        );

    const saveStepFormAnswersEpic = action$ =>
        action$.pipe(
            ofType(action.SAVE_STEP_FORM_ANSWERS_REQUESTED),
            pluck('payload'),
            switchMap(answers =>
                registrationService
                    .saveStepFormAnswers(answers)
                    .then(action.saveStepFormAnswersSuccess)
                    .catch(action.saveStepFormAnswersFail),
            ),
        );

    return combineEpics(validateStepOfFormEpic, saveStepFormAnswersEpic);
}
