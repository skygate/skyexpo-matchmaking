import React, { useState } from 'react';
import { Select } from 'antd';
import styled from '@emotion/styled';

import {
    productTags,
    industriesTags,
    sectorsTags,
    investmentStageTags,
    companyStageTags,
    targetMarketTags,
} from '../../helpers/tags';

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

    return (
        <StyledSelect
            mode="multiple"
            placeholder="Inserted are removed"
            value={selectedTags}
            onChange={handleTagSelect}
            type="text"
            name={input.name}
        >
            {filteredOptions.map(item => (
                <Select.Option key={item} value={item}>
                    {item}
                </Select.Option>
            ))}
        </StyledSelect>
    );
};
