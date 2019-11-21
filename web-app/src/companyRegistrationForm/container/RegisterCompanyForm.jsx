import React, { useState } from 'react';
import { Formik, Form } from 'formik';

import { FormQuestions } from '../components/FormQuestions';
import { formSteps } from '../components/formSteps';
import { validationPage1, validationPage2, validationPage3 } from '../components/validationSchemas';

export const RegisterCompanyForm = () => {
    const [currentStep, setCurrentStep] = useState(0);

    const validationSchemas = [validationPage1, validationPage2, validationPage3];

    const handleNextPage = props => {
        props.submitForm().then(() => {
            if (props.isValid) {
                setCurrentStep(currentStep + 1);
                props.validateForm();
                props.setTouched({});
            }
        });
    };

    const handleSubmit = values => {
        console.log('yolo values', values);
    };

    return (
        <>
            <h1>Register Company Form</h1>
            {currentStep > 2 ? (
                <h1>Thank you</h1>
            ) : (
                <Formik
                    onSubmit={handleSubmit}
                    isInitialValid={false}
                    initialValues={{
                        firstName: '',
                        lastName: '',
                        email: '',
                        firstName1: '',
                        lastName1: '',
                        email1: '',
                        firstName2: '',
                        lastName2: '',
                        email2: '',
                    }}
                    validationSchema={validationSchemas[currentStep]}
                >
                    {props => (
                        <Form>
                            {currentStep === 0 && (
                                <FormQuestions
                                    {...props}
                                    pageProps={formSteps[currentStep]}
                                    nextPage={() => handleNextPage(props)}
                                />
                            )}
                            {currentStep === 1 && (
                                <FormQuestions
                                    {...props}
                                    pageProps={formSteps[currentStep]}
                                    nextPage={() => handleNextPage(props)}
                                />
                            )}
                            {currentStep === 2 && (
                                <FormQuestions
                                    {...props}
                                    pageProps={formSteps[currentStep]}
                                    nextPage={() => handleNextPage(props)}
                                />
                            )}
                            <button type="button" onClick={() => handleNextPage(props)}>
                                {currentStep > 1 ? 'submit' : 'next page'}
                            </button>
                        </Form>
                    )}
                </Formik>
            )}
        </>
    );
};
