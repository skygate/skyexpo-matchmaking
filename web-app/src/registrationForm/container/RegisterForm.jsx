import React, { useState } from 'react';
import { connect } from 'react-redux';
import { Formik, Form } from 'formik';
import styled from '@emotion/styled';

import { FormQuestions, TopHeader } from '../components';
import { countProgress } from '../../helpers/countProgress';
import { BackButton, NextButton, ButtonsWrapper } from '../styled/buttons';
import { handleRedirect } from '../../history';
import {
    validateStepOfFormRequest,
    setStepOfRegistrationForm,
    saveStepFormAnswersRequest,
} from '../actions/registrationActions';
import { getStepValues } from '../../helpers/getStepValues';
import { color } from '../../config/values';
import { getValidationErrorsForUserType, getStep } from '../selectors/registrationSelectors';

const SectionWrapper = styled.div`
    padding: 3rem 1.5rem;
    margin: auto;
    max-width: 1000px;
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

    const handleSubmit = formProps => {
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

            currentStep > 1 && submitStepForm(formProps);
            formProps.validateForm();
            formProps.setTouched({});
        });
    };

    const handleBackPage = () => {
        setCurrentStep(currentStep - 1);
    };

    const submitStepForm = ({ values }) => {
        props.saveStepFormAnswersRequest({ formValues: values, userType: props.userType });
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
                        isInitialValid={false}
                        initialValues={initialValues}
                        validationSchema={validationSchemas[currentStep]}
                        //I don't have all props here and formik don't fire onSubmit with errors so I trigger submit from button.
                        onSubmit={() => {}}
                    >
                        {formProps => (
                            <Form>
                                <FormQuestions
                                    {...formProps}
                                    pageProps={formSteps[currentStep]}
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
                                        type="submit"
                                        onClick={() => handleSubmit(formProps)}
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
    saveStepFormAnswersRequest,
    setCurrentStep: setStepOfRegistrationForm,
})(RegisterForm);
