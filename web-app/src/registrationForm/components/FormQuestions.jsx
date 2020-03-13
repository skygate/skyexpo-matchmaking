import React from 'react';
import { FieldArray } from 'formik';
import styled from '@emotion/styled';
import Checkbox from 'antd/lib/checkbox';
import ReactSelect from 'react-select';

import { countryOptions } from '../../helpers/countryOptions';
import { selectStyles } from '../../config/selectStyles';
import { Input, Label, Error } from '../styled';
import { RadioGroup, SelectTagsInput, UploadButton, CheckboxGroup } from './';

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
    pageProps,
    countProgress,
    setFieldValue,
}) => {
    countProgress(values);

    const addHttpsPrefix = inputName => {
        inputName === 'website' && !values[inputName] && setFieldValue(inputName, 'https://');
    };

    const removeHttpsPrefix = inputName => {
        inputName === 'website' && values[inputName] === 'https://' && setFieldValue(inputName, '');
    };

    return (
        <FormQuestionsWrapper>
            {pageProps.subtitle && <h2>{pageProps.subtitle}</h2>}
            {pageProps.inputsFields.map(input => (
                <QuestionWrapper key={input.name}>
                    <Label>{input.label || input.placeholder}</Label>
                    {input.type === 'select' && (
                        <ReactSelect
                            onChange={option => {
                                setFieldValue(input.name, option.value);
                            }}
                            options={countryOptions}
                            name={input.name}
                            styles={selectStyles}
                        />
                    )}
                    {input.type === 'text' && (
                        <>
                            <Input
                                onChange={handleChange}
                                value={values[input.name]}
                                name={input.name}
                                type="text"
                                placeholder={input.placeholder}
                                onFocus={() => addHttpsPrefix(input.name)}
                                onBlur={() => removeHttpsPrefix(input.name)}
                            />
                        </>
                    )}
                    {input.type === 'textarea' && (
                        <>
                            <Input
                                onChange={handleChange}
                                value={values[input.name]}
                                name={input.name}
                                type="textarea"
                                placeholder={input.placeholder}
                            />
                        </>
                    )}
                    {input.type === 'image' && (
                        <>
                            <UploadButton
                                onChange={event =>
                                    setFieldValue('logotype', event.currentTarget.files[0])
                                }
                            ></UploadButton>
                        </>
                    )}
                    {input.type === 'team' && (
                        <FieldArray
                            name="teamMembers"
                            render={arrayOfMembers => (
                                <div>
                                    {values.teamMembers.map((_, index) => (
                                        <div key={`name${index}`}>
                                            <h2>
                                                {index > 0 ? `Member ${index + 1}` : 'Your details'}
                                            </h2>
                                            <input
                                                onChange={handleChange}
                                                name={`teamMembers.${index}.name`}
                                                type="text"
                                                placeholder="name"
                                            />
                                            {errors &&
                                                touched &&
                                                errors.teamMembers &&
                                                errors.teamMembers[index] &&
                                                touched.teamMembers &&
                                                touched.teamMembers[index] &&
                                                touched.teamMembers[index][`name`] && (
                                                    <span>{errors.teamMembers[index][`name`]}</span>
                                                )}
                                            <input
                                                onChange={handleChange}
                                                name={`teamMembers.${index}.email`}
                                                type="text"
                                                placeholder="email"
                                            />
                                            {errors &&
                                                touched &&
                                                errors.teamMembers &&
                                                errors.teamMembers[index] &&
                                                touched.teamMembers &&
                                                touched.teamMembers[index] &&
                                                touched.teamMembers[index][`email`] && (
                                                    <span>
                                                        {errors.teamMembers[index][`email`]}
                                                    </span>
                                                )}
                                            {index > 0 && (
                                                <button
                                                    type="button"
                                                    onClick={() => arrayOfMembers.remove(index)}
                                                >
                                                    remove
                                                </button>
                                            )}
                                        </div>
                                    ))}
                                    <button
                                        type="button"
                                        onClick={() =>
                                            arrayOfMembers.push({
                                                [`name`]: '',
                                                [`email`]: '',
                                            })
                                        }
                                    >
                                        add new member
                                    </button>
                                </div>
                            )}
                        />
                    )}
                    {input.type === 'selectTags' && (
                        <SelectTagsInput
                            input={input}
                            setFieldValue={setFieldValue}
                            values={values}
                        />
                    )}
                    {input.type === 'number' && (
                        <>
                            <Input
                                onChange={handleChange}
                                value={values[input.name]}
                                name={input.name}
                                type="number"
                                min="0"
                                placeholder={input.placeholder}
                            />
                        </>
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
                    {input.type !== 'team' && errors && errors && touched[input.name] && (
                        <Error>{errors[input.name]} </Error>
                    )}
                </QuestionWrapper>
            ))}
        </FormQuestionsWrapper>
    );
};
