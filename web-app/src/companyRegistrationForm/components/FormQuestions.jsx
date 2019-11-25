import React from 'react';

export const FormQuestions = ({ handleChange, values, touched, errors, pageProps }) => (
    <>
        <h1>{pageProps.title}</h1>
        {pageProps.inputsFields.map(input => (
            <div key={input.name}>
                <input
                    onChange={handleChange}
                    value={values[input.name]}
                    name={input.name}
                    type="text"
                    placeholder={input.placeholder}
                />
                {errors && touched[input.name] && <span>{errors[input.name]} </span>}
            </div>
        ))}
    </>
);
