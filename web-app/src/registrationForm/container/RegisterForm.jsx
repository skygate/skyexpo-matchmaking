import React, { useState } from 'react';
import { connect } from 'react-redux';
import { Formik, Form } from 'formik';
import styled from '@emotion/styled';
import * as R from 'ramda';

import { FormQuestions, TopHeader } from '../components';
import { countProgress } from '../../helpers/countProgress';
import { BackButton, NextButton, ButtonsWrapper } from '../styled/buttons';
import { handleRedirect } from '../../history';
import {
    validateStepOfFormRequest,
    setStepOfRegistrationForm,
} from '../actions/registrationActions';
import { getStepValues } from '../../helpers/getStepValues';
import { color } from '../../config/values';
import { getValidationErrorsForUserType, getStep } from '../selectors/registrationSelectors';

const SectionWrapper = styled.div`
    padding: 3rem 1.5rem;
    max-width: 1200px;
    color: ${color.primaryFont};
`;

const RegisterForm = ({
    formSteps,
    initialValues,
    validationSchemas,
    setCurrentStep,
    currentStep,
    ...props
}) => {
    const [completionProgress, setCompletionProgress] = useState(0);

    const handleNextPage = formProps => {
        const stepValues = getStepValues(formSteps[currentStep].inputsFields, formProps.values);

        props.validateStepOfFormRequest({
            formValues: stepValues,
            userType: props.userType,
            step: currentStep,
            isPassingFrontValidation: formProps.isValid,
        });

        formProps.submitForm().then(() => {
            if (!formProps.isValid || props.backendValidationErrors) {
                formProps.setTouched({});
                formProps.setStatus('validated');

                return;
            }

            currentStep > 1 && handleSubmit(formProps);
            formProps.validateForm();
            formProps.setTouched({});
        });
    };

    const handleBackPage = () => {
        setCurrentStep(currentStep - 1);
    };

    const handleSubmit = ({ values }) => {
        console.log('Submitted values', values);
    };

    const countCompletionProgress = questions => {
        const progress = countProgress(questions);

        setCompletionProgress(progress);
    };

    return (
        <SectionWrapper>
            {currentStep === formSteps.length ? (
                <h1>Thank you</h1>
            ) : (
                <>
                    <TopHeader
                        completionProgress={completionProgress}
                        step={currentStep}
                        title={formSteps[currentStep].title}
                    ></TopHeader>
                    <Formik
                        onSubmit={handleSubmit}
                        isInitialValid={false}
                        initialValues={initialValues}
                        validationSchema={validationSchemas[currentStep]}
                    >
                        {formProps => (
                            <Form>
                                <FormQuestions
                                    {...formProps}
                                    pageProps={formSteps[currentStep]}
                                    nextPage={() => handleNextPage(formProps)}
                                    countProgress={countCompletionProgress}
                                    backendValidationErrors={props.backendValidationErrors}
                                />
                                <ButtonsWrapper>
                                    <BackButton
                                        type="button"
                                        onClick={() =>
                                            currentStep
                                                ? handleBackPage(formProps)
                                                : handleRedirect('/')
                                        }
                                    >
                                        Back
                                    </BackButton>
                                    <NextButton
                                        type="button"
                                        disabled={!R.isEmpty(formProps.errors)}
                                        onClick={() => handleNextPage(formProps)}
                                    >
                                        {currentStep === formSteps.length - 1 ? 'Finish' : 'Next'}
                                    </NextButton>
                                </ButtonsWrapper>
                            </Form>
                        )}
                    </Formik>
                </>
            )}
        </SectionWrapper>
    );
};

const mapStateToProps = (state, ownProps) => ({
    currentStep: getStep(state),
    backendValidationErrors: getValidationErrorsForUserType(state, ownProps),
});

export default connect(mapStateToProps, {
    validateStepOfFormRequest,
    setCurrentStep: setStepOfRegistrationForm,
})(RegisterForm);
