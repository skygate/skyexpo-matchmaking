import React from 'react';
import styled from '@emotion/styled';

const RadioGroupWrapper = styled.div`
    margin-top: 1rem;
`;

const RadioLabel = styled.label`
    margin-right: 3rem;
`;

const RadioInput = styled.input`
    margin-right: 0.5rem;
`;

export const RadioGroup = ({ input, value, setFieldValue }) => (
    <RadioGroupWrapper>
        {input.options.map(option => (
            <RadioLabel key={option.optionName}>
                <RadioInput
                    key={option.name}
                    type="radio"
                    name={input.name}
                    value={option.optionValue}
                    checked={value === option.optionValue}
                    onChange={event => {
                        setFieldValue(input.name, event.target.value === 'true');
                    }}
                />
                {option.optionName}
            </RadioLabel>
        ))}
    </RadioGroupWrapper>
);
