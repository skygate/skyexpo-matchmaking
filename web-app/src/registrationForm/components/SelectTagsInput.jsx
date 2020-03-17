import React, { useState } from 'react';
import ReactSelect from 'react-select';

import { productTags, industriesTags, sectorsTags, investmentStageTags } from '../../helpers/tags';
import { selectStyles } from '../../config/selectStyles';

export const SelectTagsInput = ({ input, setFieldValue, ...props }) => {
    const [selectedTags, setSelectedTags] = useState([]);

    const tags = {
        productTags,
        industriesTags,
        sectorsTags,
        investmentStageTags,
    };

    const handleTagSelect = selectedOptions => {
        setSelectedTags(selectedOptions);
        const values = selectedOptions.map(option => option.value);
        setFieldValue(input.name, values);
    };

    const tagOptions = tags[input.tags].filter(({ value }) => !selectedTags.includes(value));

    return (
        <ReactSelect
            isMulti
            placeholder="Inserted are removed"
            value={selectedTags}
            onChange={handleTagSelect}
            onBlur={props.handleBlur}
            closeMenuOnSelect={false}
            name={input.name}
            styles={selectStyles}
            options={tagOptions}
        />
    );
};
