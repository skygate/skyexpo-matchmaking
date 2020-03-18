import React from 'react';
import styled from '@emotion/styled';

import { Input, Label, Textarea } from '../styled';
import { RadioGroup, SelectTagsInput, UploadButton, CheckboxGroup, TeamMembers, Select } from './';
import { FormFieldError } from './FormFieldError';

const FormQuestionsWrapper = styled.div`
    margin-top: 1.5rem;
    min-height: calc(100vh - 14rem);
`;

const QuestionWrapper = styled.div`
    margin-bottom: 1rem;
`;

export const FormQuestions = ({
    handleChange,
    values,
    touched,
    errors,
    setFieldValue,
    handleBlur,
    setFieldTouched,
    ...props
}) => {
    props.countProgress(values);

    const addHttpsPrefix = inputName => {
        inputName === 'website' && !values[inputName] && setFieldValue(inputName, 'https://');
    };

    const removeHttpsPrefix = inputName => {
        inputName === 'website' && values[inputName] === 'https://' && setFieldValue(inputName, '');
    };

    return (
        <FormQuestionsWrapper>
            {props.pageProps.inputsFields.map(input => (
                <QuestionWrapper key={input.name}>
                    <Label>{input.label || input.placeholder}</Label>
                    {input.type === 'select' && (
                        <Select
                            setFieldValue={setFieldValue}
                            name={input.name}
                            setFieldTouched={setFieldTouched}
                        />
                    )}
                    {input.type === 'text' && (
                        <Input
                            onChange={handleChange}
                            value={values[input.name]}
                            name={input.name}
                            type="text"
                            placeholder={input.placeholder}
                            onFocus={() => addHttpsPrefix(input.name)}
                            onBlur={event => {
                                handleBlur(event);
                                removeHttpsPrefix(input.name);
                            }}
                        />
                    )}
                    {input.type === 'textarea' && (
                        <Textarea
                            onChange={handleChange}
                            value={values[input.name]}
                            name={input.name}
                            onBlur={handleBlur}
                            placeholder={input.placeholder}
                        />
                    )}
                    {input.type === 'image' && (
                        <UploadButton
                            onChange={event =>
                                setFieldValue('logotype', event.currentTarget.files[0])
                            }
                            onBlur={handleBlur}
                        ></UploadButton>
                    )}
                    {input.type === 'team' && (
                        <TeamMembers
                            errors={errors}
                            handleChange={handleChange}
                            values={values}
                            touched={touched}
                            status={props.status}
                        ></TeamMembers>
                    )}
                    {input.type === 'selectTags' && (
                        <SelectTagsInput
                            input={input}
                            setFieldValue={setFieldValue}
                            onBlur={handleBlur}
                            values={values}
                        />
                    )}
                    {input.type === 'number' && (
                        <Input
                            onChange={handleChange}
                            onBlur={handleBlur}
                            value={values[input.name]}
                            name={input.name}
                            type="number"
                            min="0"
                            placeholder={input.placeholder}
                        />
                    )}
                    {input.type === 'radio' && (
                        <RadioGroup
                            input={input}
                            value={values[input.name]}
                            setFieldValue={setFieldValue}
                        />
                    )}
                    {input.type === 'checkboxGroup' && (
                        <div name={input.name}>
                            <CheckboxGroup
                                input={input}
                                values={values[input.name]}
                                setFieldValue={setFieldValue}
                            />
                        </div>
                    )}

                    {input.type !== 'team' && (
                        <FormFieldError
                            errors={errors?.[input.name]}
                            backendErrors={props.backendValidationErrors?.[input.name]}
                            touched={touched?.[input.name]}
                            value={values[input.name]}
                            status={props.status}
                        ></FormFieldError>
                    )}
                </QuestionWrapper>
            ))}
        </FormQuestionsWrapper>
    );
};
