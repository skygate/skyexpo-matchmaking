import React from 'react';

import { Error } from '../styled';

export const FormFieldError = ({ errors, backendErrors, touched, status, value }) => {
    const showFrontendErrors = errors && status === 'validated';
    const showBackendErrors = !errors && !!value && !touched && status === 'validated';

    return (
        <>
            {showFrontendErrors && <Error>{errors}</Error>}
            {showBackendErrors && <Error>{backendErrors}</Error>}
        </>
    );
};
