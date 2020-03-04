import React, { useState } from 'react';
import { connect } from 'react-redux';
import { Formik, Form } from 'formik';
import { Progress } from 'antd';
import styled from '@emotion/styled';
import * as R from 'ramda';

import { FormQuestions } from '../components/FormQuestions';
import { handleRedirect } from '../../history';
import { validateStepOfFormRequest } from '../actions/registrationActions';

const SectionWrapper = styled.div`
    max-width: 400px;
    margin: 10rem auto;
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
        const currentStepFormInputs = formSteps[currentStep].inputsFields;
        const condition = currentStepFormInputs.map(a => a.name);
        const data = props.values;

        const stepValues = Object.keys(data)
            .filter(value => condition.includes(value))
            .reduce(
                (obj, key) => ({
                    ...obj,
                    [key]: data[key],
                }),
                {},
            );

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
                    <h1>Registration step {currentStep + 1}</h1>
                    <Progress type="circle" percent={completionProgress} width={80} />
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
                                    {currentStep ? (
                                        <button type="button" onClick={() => handleBackPage(props)}>
                                            back
                                        </button>
                                    ) : (
                                        <button onClick={() => handleRedirect('/')}>back</button>
                                    )}
                                    <button type="button" onClick={() => handleNextPage(props)}>
                                        {currentStep === formSteps.length - 1
                                            ? 'submit'
                                            : 'next page'}
                                    </button>
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
