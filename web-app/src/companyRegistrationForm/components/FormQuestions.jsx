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
                                    {values.teamMembers.map((e, index) => (
                                        <div key={index}>
                                            <input
                                                onChange={handleChange}
                                                name={`teamMembers.${index}.name`}
                                                type="text"
                                                placeholder={`teamMembers.${index}.name`}
                                            />
                                            <input
                                                onChange={handleChange}
                                                name={`teamMembers.${index}.email`}
                                                type="text"
                                                placeholder={`teamMembers.${index}.email`}
                                            />
                                        </div>
                                    ))}

                                    <button
                                        type="button"
                                        onClick={() => arrayOfMembers.push({ name: '', email: '' })}
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
                          errors.teamMembers.map(error => (
                              <>
                                  <span key={error.name}>{error.name}</span>{' '}
                                  <span key={error.email}>{error.email}</span>
                              </>
                          ))
                        : errors && touched[input.name] && <span>{errors[input.name]} </span>}
                </div>
            ))}
        </>
    );
};