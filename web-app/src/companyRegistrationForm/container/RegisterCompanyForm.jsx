import React, { useState } from 'react';
import { Formik, Form } from 'formik';
import { Progress } from 'antd';
import styled from '@emotion/styled';

import { FormQuestions } from '../components/FormQuestions';
import { formSteps } from '../components/formSteps';
import { validationPage1, validationPage2, validationPage3 } from '../components/validationSchemas';

const SectionWrapper = styled.div`
    max-width: 400px;
    margin: 10rem auto;
`;

const initialValues = {
    companyName: '',
    website: '',
    phone: '',
    companyContact: '',
    country: '',
    foundingDate: '',
    shortDescription: '',
    logo: '',
    teamMembers: [
        {
            name0: '',
            email0: '',
        },
    ],
    industries: [''],
    sectors: '',
    companyStage: [''],
    productType: [''],
};

export const RegisterCompanyForm = () => {
    const [currentStep, setCurrentStep] = useState(0);
    const [completionProgress, setCompletionProgress] = useState(0);

    const validationSchemas = [validationPage1, validationPage2, validationPage3];

    const handleNextPage = props => {
        props.submitForm().then(() => {
            if (props.isValid) {
                currentStep > 1 && handleSubmit(props);
                setCurrentStep(currentStep + 1);
                props.validateForm();
                props.setTouched({});
            }
        });
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
            <h1>Register Company Form</h1>
            <Progress type="circle" percent={completionProgress} width={80} />
            {currentStep > 2 ? (
                <h1>Thank you</h1>
            ) : (
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
                            <button type="button" onClick={() => handleNextPage(props)}>
                                {currentStep > 1 ? 'submit' : 'next page'}
                            </button>
                        </Form>
                    )}
                </Formik>
            )}
        </SectionWrapper>
    );
};
