import React from 'react';
import { FieldArray } from 'formik';
import { Radio, Checkbox } from 'antd';

import { countryList } from '../../helpers/countryList';
import { SelectTagsInput } from './SelectTagsInput';

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

    const condition = pageProps.inputsFields.map(a => a.name);

    const data = values;

    const stepValues = Object.keys(data)
        .filter(value => condition.includes(value))
        .reduce(
            (obj, key) => ({
                ...obj,
                [key]: data[key],
            }),
            {},
        );

    const addHttpsPrefix = inputName => {
        inputName === 'website' && !values[inputName] && setFieldValue(inputName, 'https://');
    };

    const removeHttpsPrefix = inputName => {
        inputName === 'website' && values[inputName] === 'https://' && setFieldValue(inputName, '');
    };

    const handleCheckboxClick = checkedValues => {
        setFieldValue('businessType', checkedValues);
    };

    return (
        <>
            <h1>{pageProps.title}</h1>
            {pageProps.subtitle && <h2>{pageProps.subtitle}</h2>}
            {pageProps.inputsFields.map(input => (
                <div key={input.name}>
                    {input.type === 'select' && (
                        <>
                            <select onChange={handleChange} name={input.name}>
                                {countryList.map(country => (
                                    <option key={country.code} value={country.code}>
                                        {country.name}
                                    </option>
                                ))}
                            </select>
                        </>
                    )}
                    {input.type === 'text' && (
                        <>
                            <input
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
                            <input
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
                            <input
                                onChange={event =>
                                    setFieldValue('logotype', event.currentTarget.files[0])
                                }
                                name={input.name}
                                type="file"
                                placeholder={input.placeholder}
                            />
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
                                                name={`teamMembers.${index}.name${index}`}
                                                type="text"
                                                placeholder="name"
                                            />
                                            {errors &&
                                                touched &&
                                                errors.teamMembers &&
                                                errors.teamMembers[index] &&
                                                touched.teamMembers &&
                                                touched.teamMembers[index] &&
                                                touched.teamMembers[index][`name${index}`] && (
                                                    <span>
                                                        {errors.teamMembers[index][`name${index}`]}
                                                    </span>
                                                )}
                                            <input
                                                onChange={handleChange}
                                                name={`teamMembers.${index}.email${index}`}
                                                type="text"
                                                placeholder="email"
                                            />
                                            {errors &&
                                                touched &&
                                                errors.teamMembers &&
                                                errors.teamMembers[index] &&
                                                touched.teamMembers &&
                                                touched.teamMembers[index] &&
                                                touched.teamMembers[index][`email${index}`] && (
                                                    <span>
                                                        {errors.teamMembers[index][`email${index}`]}
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
                                                [`name${values.teamMembers.length}`]: '',
                                                [`email${values.teamMembers.length}`]: '',
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
                            <input
                                onChange={handleChange}
                                value={values[input.name]}
                                name={input.name}
                                type="number"
                                placeholder={input.placeholder}
                            />
                        </>
                    )}
                    {input.type === 'radio' && (
                        <Radio.Group
                            onChange={handleChange}
                            value={values[input.name]}
                            name={input.name}
                        >
                            {input.options.map(option => (
                                <Radio key={option.optionName} value={option.optionValue}>
                                    {option.optionName}
                                </Radio>
                            ))}
                        </Radio.Group>
                    )}
                    {input.type === 'checkboxGroup' && (
                        <div name={input.name}>
                            <Checkbox.Group
                                name={input.name}
                                options={input.options}
                                onChange={handleCheckboxClick}
                            />
                        </div>
                    )}
                    {input.type !== 'team' && errors && errors && touched[input.name] && (
                        <span>{errors[input.name]} </span>
                    )}
                </div>
            ))}
        </>
    );
};
