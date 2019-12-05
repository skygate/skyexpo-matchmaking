import React, { useState } from 'react';
import { Select } from 'antd';

import {
    productTags,
    industriesTags,
    sectorsTags,
    investmentStageTags,
    companyStageTags,
    targetMarketTags,
} from '../../helpers/tags';

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
        <Select
            mode="multiple"
            placeholder="Inserted are removed"
            value={selectedTags}
            onChange={handleTagSelect}
            style={{ width: '100%' }}
            type="text"
            name={input.name}
        >
            {filteredOptions.map(item => (
                <Select.Option key={item} value={item}>
                    {item}
                </Select.Option>
            ))}
        </Select>
    );
};
