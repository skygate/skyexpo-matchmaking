import React from 'react';
import { FieldArray } from 'formik';

import { countryList } from '../../helpers/countryList';

export const FormQuestions = ({
    handleChange,
    values,
    touched,
    errors,
    pageProps,
    countProgress,
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

    return (
        <>
            <h1>{pageProps.title}</h1>
            {pageProps.inputsFields.map(input => (
                <div key={input.name}>
                    {input.type === 'select' && (
                        <>
                            <select onChange={handleChange} name={input.name}>
                                {countryList.map(country => (
                                    <option key={country} value={country}>
                                        {country}
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
                                onChange={handleChange}
                                value={values[input.name]}
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
                                            <input
                                                onChange={handleChange}
                                                name={`teamMembers.${index}.name${index}`}
                                                type="text"
                                                placeholder="name"
                                            />
                                            {errors &&
                                                errors.teamMembers &&
                                                errors.teamMembers[index] && (
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
                                                errors.teamMembers &&
                                                errors.teamMembers[index] && (
                                                    <span>
                                                        {errors.teamMembers[index][`email${index}`]}
                                                    </span>
                                                )}
                                            <button
                                                type="button"
                                                onClick={() => arrayOfMembers.remove(index)}
                                            >
                                                remove
                                            </button>
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
                                        add
                                    </button>
                                </div>
                            )}
                        />
                    )}
                    {input.type !== 'team' && errors && errors && touched[input.name] && (
                        <span>{errors[input.name]} </span>
                    )}
                </div>
            ))}
        </>
    );
};
