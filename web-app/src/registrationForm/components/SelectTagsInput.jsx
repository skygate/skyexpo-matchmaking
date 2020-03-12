import React, { useState } from 'react';
import Select from 'antd/lib/select';
import styled from '@emotion/styled';
import ReactSelect from 'react-select';

import {
    productTags,
    industriesTags,
    sectorsTags,
    investmentStageTags,
    companyStageTags,
    targetMarketTags,
} from '../../helpers/tags';
import { getOptionsFromValues } from '../../helpers/getOptionsFromValues';
import { selectStyles } from '../../config/selectStyles';

export const StyledSelect = styled(Select)`
    max-width: 100%;
`;
export const SelectTagsInput = ({ input, setFieldValue }) => {
    const [selectedTags, setSelectedTags] = useState([]);

    const tags = {
        productTags,
        industriesTags,
        sectorsTags,
        investmentStageTags,
        companyStageTags,
        targetMarketTags,
    };

    const handleTagSelect = selectedItem => {
        setSelectedTags(selectedItem);
        setFieldValue(input.name, selectedItem);
    };

    const filteredOptions = tags[input.tags].filter(tag => !selectedTags.includes(tag));
    const tagOptions = getOptionsFromValues(filteredOptions);
    return (
        <ReactSelect
            isMulti
            placeholder="Inserted are removed"
            value={selectedTags}
            onChange={handleTagSelect}
            closeMenuOnSelect={false}
            name={input.name}
            styles={selectStyles}
            options={tagOptions}
        />
    );
};
