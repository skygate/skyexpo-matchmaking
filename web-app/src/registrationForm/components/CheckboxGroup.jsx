import React from 'react';
import styled from '@emotion/styled';

import { getNewCheckboxValues } from '../../helpers/getNewCheckboxValues';

const RadioGroupWrapper = styled.div`
    margin-top: 1rem;
    display: flex;
    flex-direction: column;
`;
const RadioElementWrapper = styled.div`
    margin-top: 0.5rem;
`;

const RadioLabel = styled.label`
    display: inline-block;
    width: 11rem;
    margin-right: 3rem;
`;

const RadioInput = styled.input`
    margin-left: 0.5rem;
`;

export const CheckboxGroup = ({ input, values, setFieldValue }) => (
    <RadioGroupWrapper>
        {input.options.map(option => (
            <RadioElementWrapper key={option.label}>
                <RadioLabel>{option.label}</RadioLabel>
                <RadioInput
                    key={option.name}
                    type="checkbox"
                    name={input.name}
                    value={option.value}
                    checked={values.includes(option.value)}
                    onChange={event => {
                        setFieldValue(input.name, event.target.value);
                    }}
                />
            </RadioElementWrapper>
        ))}
    </RadioGroupWrapper>
);
