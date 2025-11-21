// Composable pour le formatage des dates

export function useDateFormat() {
  const formatDate = (dateString) => {
    if (!dateString) return '-'
    const date = new Date(dateString)
    return date.toLocaleDateString('fr-FR', {
      day: '2-digit',
      month: '2-digit',
      year: 'numeric'
    })
  }

  const formatBirthDate = (dateString) => {
    if (!dateString) return '-'
    const date = new Date(dateString)
    const day = date.getDate()
    const month = date.getMonth() + 1
    const year = date.getFullYear()
    return `${day.toString().padStart(2, '0')}/${month.toString().padStart(2, '0')}/${year} à -`
  }

  const formatSession = (semesterName) => {
    const year = new Date().getFullYear()
    return `${semesterName} ${year}`
  }

  return {
    formatDate,
    formatBirthDate,
    formatSession
  }
}
