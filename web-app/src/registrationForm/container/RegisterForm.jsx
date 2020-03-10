import React, { useState } from 'react';
import { connect } from 'react-redux';
import { Formik, Form } from 'formik';
import styled from '@emotion/styled';

import { FormQuestions } from '../components/FormQuestions';
import { TopHeader } from '../components/TopHeader';

import { BackButton, NextButton, ButtonsWrapper } from '../styled/buttons';

import { handleRedirect } from '../../history';
import { validateStepOfFormRequest } from '../actions/registrationActions';
import { getStepValues } from '../../helpers/getStepValues';

const SectionWrapper = styled.div`
    padding: 0 1.5rem;
`;

const RegisterForm = ({
    formSteps,
    initialValues,
    validationSchemas,
    userType,
    validateStepOfFormRequest,
}) => {
    const [currentStep, setCurrentStep] = useState(0);
    const [completionProgress, setCompletionProgress] = useState(0);

    const handleNextPage = props => {
        const stepValues = getStepValues(formSteps[currentStep].inputsFields, props.initialValues);

        validateStepOfFormRequest(stepValues, userType, currentStep + 1);

        props.submitForm().then(() => {
            if (!props.isValid) return;

            currentStep > 1 && handleSubmit(props);
            setCurrentStep(currentStep + 1);
            props.validateForm();
            props.setTouched({});
        });
    };

    const handleBackPage = () => {
        setCurrentStep(currentStep - 1);
    };

    const handleSubmit = ({ values }) => {
        console.log('Submitted values', values);
    };

    const countCompletionProgress = questions => {
        const allQuestions = Object.values(questions).flat();
        const questionsWithoutTeamMembers = allQuestions.filter(
            question => typeof question !== 'object',
        );
        const questionsAboutTeamMembers = allQuestions
            .flat()
            .filter(question => typeof question === 'object')
            .map(question => Object.values(question))
            .flat();
        const allQuestionsNumber = questionsAboutTeamMembers.concat(questionsWithoutTeamMembers)
            .length;
        const answeredQuestion = questionsAboutTeamMembers
            .concat(questionsWithoutTeamMembers)
            .filter(a => a !== '').length;

        setCompletionProgress(Math.round((answeredQuestion / allQuestionsNumber) * 100));
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
                    ></TopHeader>
                    <div>
                        <Formik
                            onSubmit={handleSubmit}
                            isInitialValid={false}
                            initialValues={initialValues}
                            validationSchema={validationSchemas[currentStep]}
                        >
                            {props => (
                                <Form>
                                    <FormQuestions
                                        {...props}
                                        pageProps={formSteps[currentStep]}
                                        nextPage={() => handleNextPage(props)}
                                        countProgress={countCompletionProgress}
                                    />
                                    <ButtonsWrapper>
                                        {currentStep ? (
                                            <BackButton
                                                type="button"
                                                onClick={() => handleBackPage(props)}
                                            >
                                                Back
                                            </BackButton>
                                        ) : (
                                            <BackButton onClick={() => handleRedirect('/')}>
                                                Back
                                            </BackButton>
                                        )}
                                        <NextButton
                                            type="button"
                                            onClick={() => handleNextPage(props)}
                                        >
                                            {currentStep === formSteps.length - 1
                                                ? 'Finish'
                                                : 'Next'}
                                        </NextButton>
                                    </ButtonsWrapper>
                                </Form>
                            )}
                        </Formik>
                    </div>
                </>
            )}
        </SectionWrapper>
    );
};

export default connect(null, { validateStepOfFormRequest })(RegisterForm);
