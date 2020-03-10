export const countProgress = questions => {
    const allQuestions = Object.values(questions).flat();
    const questionsWithoutTeamMembers = allQuestions.filter(
        question => typeof question !== 'object',
    );
    const questionsAboutTeamMembers = allQuestions
        .flat()
        .filter(question => typeof question === 'object')
        .map(question => Object.values(question))
        .flat();
    const allQuestionsNumber = questionsAboutTeamMembers.concat(questionsWithoutTeamMembers).length;
    const answeredQuestion = questionsAboutTeamMembers
        .concat(questionsWithoutTeamMembers)
        .filter(a => a !== '').length;

    return Math.round((answeredQuestion / allQuestionsNumber) * 100);
};
