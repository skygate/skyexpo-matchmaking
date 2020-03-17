import React from 'react';
import ReactSelect from 'react-select';

import { stageOptions } from '../../config/companyStageOptions';
import { selectStyles } from '../../config/selectStyles';
import { countryOptions } from '../../helpers/countryOptions';

const allSelectOptions = {
    stage: stageOptions,
    country: countryOptions,
};

export const Select = ({ name, setFieldValue, setFieldTouched }) => {
    const options = allSelectOptions[name];

    return (
        <ReactSelect
            onChange={option => setFieldValue(name, option.value)}
            options={options}
            name={name}
            styles={selectStyles}
            onBlur={() => setFieldTouched(name, true)}
        />
    );
};
