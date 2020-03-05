export const startupFormSteps = [
    {
        title: 'Main info',
        inputsFields: [
            { name: 'name', placeholder: 'Startup name', type: 'text' },
            { name: 'website', placeholder: 'Website', type: 'text' },
            { name: 'phoneNumber', placeholder: '+48 123 123 123', type: 'text' },
            { name: 'email', placeholder: 'Email', type: 'text' },
            { name: 'country', placeholder: 'Country', type: 'select' },
            { name: 'logotype', placeholder: 'Logo', type: 'image' },
            { name: 'foundingDate', placeholder: 'YYYY-MM-YY', type: 'text' },
            { name: 'description', placeholder: 'Short description', type: 'textarea' },
        ],
    },
    {
        title: 'Team members',
        subtitle: 'Participating on the skyexpo',
        inputsFields: [
            {
                name: 'teamMembers',
                placeholder: 'Team members',
                type: 'team',
                inputs: [
                    {
                        name: 'name0',
                        placeholder: 'John Doe',
                    },
                    {
                        name: 'email0',
                        placeholder: 'johndoe@email.com',
                    },
                ],
            },
        ],
    },
    {
        title: 'Matching parameters',
        inputsFields: [
            {
                name: 'industries',
                placeholder: 'Industries',
                type: 'selectTags',
                tags: 'industriesTags',
            },
            { name: 'sectors', placeholder: 'Sectors', type: 'selectTags', tags: 'sectorsTags' },
            {
                name: 'investmentStage',
                placeholder: 'Investment stage',
                type: 'selectTags',
                tags: 'investmentStageTags',
            },
            {
                name: 'companyStage',
                placeholder: 'Company stage',
                type: 'selectTags',
                tags: 'companyStageTags',
            },
            {
                name: 'productTypes',
                placeholder: 'Product type',
                type: 'selectTags',
                tags: 'productTags',
            },
            {
                name: 'isProductOnMarket',
                placeholder: 'Product on Market',
                type: 'radio',
                options: [
                    { optionName: 'No', optionValue: false },
                    { optionName: 'Yes', optionValue: true },
                ],
            },
            {
                name: 'targetMarket',
                placeholder: 'Target Market',
                type: 'selectTags',
                tags: 'targetMarketTags',
            },
            {
                name: 'businessType',
                placeholder: 'Business Type',
                type: 'checkboxGroup',
                options: [
                    {
                        label: 'B2B (Business to Business)',
                        value: 'B2B (Business to Business)',
                    },
                    {
                        label: 'B2C (Business to Customer)',
                        value: 'B2C (Business to Customer)',
                    },
                ],
            },
            {
                name: 'minInvestmentSize',
                placeholder: 'Minimum investment size (EUR)',
                type: 'number',
            },
            {
                name: 'maxInvestmentSize',
                placeholder: 'Maximum investment size (EUR)',
                type: 'number',
            },
        ],
    },
];

export const companyInvestorFormSteps = [
    {
        title: 'Main info',
        inputsFields: [
            { name: 'name', placeholder: 'Company name', type: 'text' },
            { name: 'website', placeholder: 'Website', type: 'text' },
            { name: 'phoneNumber', placeholder: '+48 123 123 123', type: 'text' },
            { name: 'email', placeholder: 'Email', type: 'text' },
            { name: 'country', placeholder: 'Country', type: 'select' },
            { name: 'logotype', placeholder: 'Logo', type: 'image' },
            { name: 'foundingDate', placeholder: 'YYYY-MM-YY', type: 'text' },
            { name: 'description', placeholder: 'Short description', type: 'textarea' },
        ],
    },
    {
        title: 'Team members',
        subtitle: 'Participating on the skyexpo',
        inputsFields: [
            {
                name: 'teamMembers',
                placeholder: 'Team members',
                type: 'team',
                inputs: [
                    {
                        name: 'name0',
                        placeholder: 'John Doe',
                    },
                    {
                        name: 'email0',
                        placeholder: 'johndoe@email.com',
                    },
                ],
            },
        ],
    },
    {
        title: 'Matching parameters',
        inputsFields: [
            {
                name: 'industries',
                placeholder: 'Industries',
                type: 'selectTags',
                tags: 'industriesTags',
            },
            { name: 'sectors', placeholder: 'Sectors', type: 'selectTags', tags: 'sectorsTags' },
            {
                name: 'investmentStage',
                placeholder: 'Investment stage',
                type: 'selectTags',
                tags: 'investmentStageTags',
            },
            {
                name: 'companyStage',
                placeholder: 'Company stage',
                type: 'selectTags',
                tags: 'companyStageTags',
            },
            {
                name: 'productTypes',
                placeholder: 'Product type',
                type: 'selectTags',
                tags: 'productTags',
            },
            {
                name: 'isProductOnMarket',
                placeholder: 'Product on Market',
                type: 'radio',
                options: [
                    { optionName: 'No', optionValue: false },
                    { optionName: 'Yes', optionValue: true },
                ],
            },
            {
                name: 'targetMarket',
                placeholder: 'Target Market',
                type: 'selectTags',
                tags: 'targetMarketTags',
            },
            {
                name: 'businessType',
                placeholder: 'Business Type',
                type: 'checkboxGroup',
                options: [
                    {
                        label: 'B2B (Business to Business)',
                        value: 'B2B (Business to Business)',
                    },
                    {
                        label: 'B2C (Business to Customer)',
                        value: 'B2C (Business to Customer)',
                    },
                ],
            },
            {
                name: 'minInvestmentSize',
                placeholder: 'Minimum investment size (EUR)',
                type: 'number',
            },
            {
                name: 'maxInvestmentSize',
                placeholder: 'Maximum investment size (EUR)',
                type: 'number',
            },
        ],
    },
];

export const individualInvestorFormSteps = [
    {
        title: 'Main info',
        inputsFields: [
            { name: 'name', placeholder: 'Full name', type: 'text' },
            { name: 'website', placeholder: 'Website', type: 'text' },
            { name: 'phoneNumber', placeholder: '+48 123 123 123', type: 'text' },
            { name: 'email', placeholder: 'Your email', type: 'text' },
            { name: 'country', placeholder: 'Country', type: 'select' },
            { name: 'logotype', placeholder: 'Logo', type: 'image' },
            { name: 'foundingDate', placeholder: 'YYYY-MM-YY', type: 'text' },
            { name: 'description', placeholder: 'Short description', type: 'textarea' },
        ],
    },
    {
        title: 'Matching parameters',
        inputsFields: [
            {
                name: 'industries',
                placeholder: 'Industries',
                type: 'selectTags',
                tags: 'industriesTags',
            },
            { name: 'sectors', placeholder: 'Sectors', type: 'selectTags', tags: 'sectorsTags' },
            {
                name: 'investmentStage',
                placeholder: 'Investment stage',
                type: 'selectTags',
                tags: 'investmentStageTags',
            },
            {
                name: 'companyStage',
                placeholder: 'Company stage',
                type: 'selectTags',
                tags: 'companyStageTags',
            },
            {
                name: 'productTypes',
                placeholder: 'Product type',
                type: 'selectTags',
                tags: 'productTags',
            },
            {
                name: 'isProductOnMarket',
                placeholder: 'Product on Market',
                type: 'radio',
                options: [
                    { optionName: 'No', optionValue: false },
                    { optionName: 'Yes', optionValue: true },
                ],
            },
            {
                name: 'targetMarket',
                placeholder: 'Target Market',
                type: 'selectTags',
                tags: 'targetMarketTags',
            },
            {
                name: 'businessType',
                placeholder: 'Business Type',
                type: 'checkboxGroup',
                options: [
                    {
                        label: 'B2B (Business to Business)',
                        value: 'B2B (Business to Business)',
                    },
                    {
                        label: 'B2C (Business to Customer)',
                        value: 'B2C (Business to Customer)',
                    },
                ],
            },
            {
                name: 'minInvestmentSize',
                placeholder: 'Minimum investment size (EUR)',
                type: 'number',
            },
            {
                name: 'maxInvestmentSize',
                placeholder: 'Maximum investment size (EUR)',
                type: 'number',
            },
        ],
    },
];
