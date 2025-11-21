// Composable pour le formatage des notes et résultats

export function useGradeFormat() {
  const formatGrade = (grade) => {
    return grade ? grade.toFixed(2) : '-'
  }

  const getResult = (grade) => {
    if (!grade) return '-'
    if (grade >= 10) return 'Admis'
    return 'Ajourné'
  }

  const getResultClass = (grade) => {
    if (!grade) return 'text-muted'
    return grade >= 10 ? 'text-success' : 'text-danger'
  }

  const getMention = (average) => {
    if (!average) return '-'
    if (average >= 16) return 'Très Bien'
    if (average >= 14) return 'Bien'
    if (average >= 12) return 'Assez Bien'
    if (average >= 10) return 'Passable'
    return 'Ajourné'
  }

  const getGradeCode = (grade) => {
    if (!grade) return 'AR'
    if (grade >= 16) return 'TB'
    if (grade >= 14) return 'B'
    if (grade >= 12) return 'AB'
    if (grade >= 10) return 'P'
    return 'AR'
  }

  return {
    formatGrade,
    getResult,
    getResultClass,
    getMention,
    getGradeCode
  }
}
