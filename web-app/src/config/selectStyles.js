import { color, fontSize } from './values';

export const selectStyles = {
    option: provided => ({
        ...provided,
        color: color.primaryFont,
        backgroundColor: color.elementBackground,
        padding: '0.55rem 0 0.55rem 2rem',
        transition: '0.5s',
        '&:hover': {
            backgroundColor: color.primaryBackground,
        },
    }),
    valueContainer: provided => ({
        ...provided,
        color: color.primaryFont,
        backgroundColor: color.elementBackground,
        opacity: 0.7,
        borderRadius: '0.3rem 0 0 0.3rem',
        padding: '0.55rem 0 0.55rem 2rem',
    }),
    indicatorsContainer: provided => ({
        ...provided,
        opacity: 0.7,
        borderRadius: '0 0.3rem 0.3rem 0',
        backgroundColor: color.elementBackground,
    }),
    control: provided => ({
        ...provided,
        border: 'none',
        boxShadow: 'none',
        '&:hover': {
            border: 'none',
        },
        fontSize: fontSize.normal,
    }),
    container: provided => ({
        ...provided,
        marginTop: '0.5rem',
    }),
    indicatorSeparator: provided => ({
        ...provided,
        display: 'none',
    }),
    multiValue: provided => ({
        ...provided,
        backgroundColor: 'white',
    }),
    noOptionsMessage: provided => ({
        ...provided,
        backgroundColor: color.elementBackground,
    }),
};
