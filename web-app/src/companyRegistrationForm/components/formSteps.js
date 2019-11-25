export const formSteps = [
    {
        title: 'Main info',
        inputsFields: [
            { name: 'companyName', placeholder: 'Company name', type: 'text' },
            { name: 'website', placeholder: 'Website', type: 'text' },
            { name: 'phone', placeholder: '+48 123 123 123', type: 'text' },
            { name: 'companyContact', placeholder: 'Email', type: 'text' },
            { name: 'country', placeholder: 'Country', type: 'select' },
            { name: 'foundingDate', placeholder: 'Founding date', type: 'text' },
            { name: 'shortDescription', placeholder: 'Short description', type: 'textarea' },
        ],
    },
    {
        title: 'Your team',
        inputsFields: [
            { name: 'logo', placeholder: 'Logo', type: 'image' },
            {
                name: 'teamMembers',
                placeholder: 'Team members',
                type: 'team',
                inputs: [
                    {
                        name: 'name',
                        placeholder: 'John Doe',
                    },
                    {
                        name: 'email',
                        placeholder: 'johndoe@email.com',
                    },
                ],
            },
        ],
    },
    {
        title: 'Startup sectors',
        inputsFields: [
            { name: 'industries', placeholder: 'Industries', type: 'text' },
            { name: 'sectors', placeholder: 'Sectors', type: 'text' },
            { name: 'companyStage', placeholder: 'Company stage', type: 'text' },
            { name: 'productType', placeholder: 'Product type', type: 'text' },
        ],
    },
];
