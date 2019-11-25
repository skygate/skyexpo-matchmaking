import React from 'react';

import { countryList } from '../../helpers/countryList';
import { FieldArray } from 'formik';

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
                        <select onChange={handleChange} name={input.name}>
                            {countryList.map(country => (
                                <option key={country} value={country}>
                                    {country}
                                </option>
                            ))}
                        </select>
                    )}
                    {input.type === 'text' && (
                        <input
                            onChange={handleChange}
                            value={values[input.name]}
                            name={input.name}
                            type="text"
                            placeholder={input.placeholder}
                        />
                    )}
                    {input.type === 'textarea' && (
                        <input
                            onChange={handleChange}
                            value={values[input.name]}
                            name={input.name}
                            type="textarea"
                            placeholder={input.placeholder}
                        />
                    )}
                    {input.type === 'image' && (
                        <input
                            onChange={handleChange}
                            value={values[input.name]}
                            name={input.name}
                            type="file"
                            placeholder={input.placeholder}
                        />
                    )}
                    {input.type === 'team' && (
                        <FieldArray
                            name="teamMembers"
                            render={arrayOfMembers => (
                                <div>
                                    {values.teamMembers.map((_, index) => (
                                        <div key={`teamMembers.${index}.name`}>
                                            <input
                                                onChange={handleChange}
                                                name={`teamMembers.${index}.name`}
                                                type="text"
                                                placeholder="name"
                                            />
                                            <input
                                                onChange={handleChange}
                                                name={`teamMembers.${index}.email`}
                                                type="text"
                                                placeholder="email"
                                            />
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
                                                name: '',
                                                email: '',
                                            })
                                        }
                                    >
                                        add
                                    </button>
                                </div>
                            )}
                        />
                    )}
                    {input.name === 'teamMembers'
                        ? errors &&
                          errors.teamMembers &&
                          touched.teamMembers &&
                          errors.teamMembers.map(
                              error =>
                                  error && (
                                      <>
                                          <span key={error.name}>{error.name}</span>
                                          <span key={error.email}>{error.email}</span>
                                      </>
                                  ),
                          )
                        : errors && touched[input.name] && <span>{errors[input.name]} </span>}
                </div>
            ))}
        </>
    );
};
