import { combineReducers } from 'redux';

import { registrationForm } from '../src/registrationForm/reducers/registrationReducer';

export const rootReducer = combineReducers({
    registrationForm,
});
