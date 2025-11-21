// Données de test mock pour le développement frontend

// Comptes ADMIN only - Étudiants n'ont pas accès
const mockUsers = [
  {
    id_user: 1,
    username: 'admin.bureau',
    email: 'admin@univ.mg',
    mot_de_passe: 'AdminPass123!',
    role: 'ADMIN',
    est_actif: true,
    firstName: 'Administrateur',
    lastName: 'Bureau',
    birthDate: '1990-01-01'
  },
  {
    id_user: 2,
    username: 'secretaire',
    email: 'secretaire@univ.mg',
    mot_de_passe: 'SecPass123!',
    role: 'USER',
    est_actif: true,
    firstName: 'Secrétaire',
    lastName: 'École',
    birthDate: '1992-05-15'
  }
]

// Référence aux étudiants pour affichage par ADMIN (pas de compte login)
const mockStudents = [
  {
    id_etudiant: 1,
    nom: 'Rakoto',
    prenom: 'Jean',
    date_naissance: '2002-05-15',
    email: 'jean.rakoto@univ.mg'
  },
  {
    id_etudiant: 2,
    nom: 'Rasoa',
    prenom: 'Marie',
    date_naissance: '2003-08-20',
    email: 'marie.rasoa@univ.mg'
  },
  {
    id_etudiant: 3,
    nom: 'Rabe',
    prenom: 'Paul',
    date_naissance: '2002-12-10',
    email: 'paul.rabe@univ.mg'
  }
]

const mockSemesters = [
  { id: 1, name: 'S1' },
  { id: 2, name: 'S2' },
  { id: 3, name: 'S3' },
  { id: 4, name: 'S4' }
]

const mockParcours = {
  4: [
    { id: 1, name: 'Développement', semesterId: 4 },
    { id: 2, name: 'Web et Design', semesterId: 4 },
    { id: 3, name: 'Bases de Données et Réseaux', semesterId: 4 }
  ]
}

const mockStudentAverages = [
  {
    id: 1,
    firstName: 'Jean',
    lastName: 'Rakoto',
    email: 'jean.rakoto@univ.mg',
    s1Average: 14.25,
    s2Average: 13.50,
    s3Average: 12.75,
    s4Average: 13.98
  },
  {
    id: 2,
    firstName: 'Marie',
    lastName: 'Rasoa',
    email: 'marie.rasoa@univ.mg',
    s1Average: 14.00,
    s2Average: 15.20,
    s3Average: 13.50,
    s4Average: 14.75
  },
  {
    id: 3,
    firstName: 'Paul',
    lastName: 'Rabe',
    email: 'paul.rabe@univ.mg',
    s1Average: 13.50,
    s2Average: 12.80,
    s3Average: 11.75,
    s4Average: 12.50
  }
]

const mockStudentDetails = {
  1: {
    id: 1,
    firstName: 'Jean',
    lastName: 'Rakoto',
    email: 'jean.rakoto@univ.mg',
    birthDate: '2002-05-15',
    semesterAverages: {
      S1: 14.25,
      S2: 13.50,
      S3: 12.75,
      S4: 13.98
    }
  },
  2: {
    id: 2,
    firstName: 'Marie',
    lastName: 'Rasoa',
    email: 'marie.rasoa@univ.mg',
    birthDate: '2003-08-20',
    semesterAverages: {
      S1: 14.00,
      S2: 15.20,
      S3: 13.50,
      S4: 14.75
    }
  },
  3: {
    id: 3,
    firstName: 'Paul',
    lastName: 'Rabe',
    email: 'paul.rabe@univ.mg',
    birthDate: '2002-12-10',
    semesterAverages: {
      S1: 13.50,
      S2: 12.80,
      S3: 11.75,
      S4: 12.50
    }
  }
}

const mockSemesterGrades = {
  '1-1': {
    student: { id: 1, firstName: 'Jean', lastName: 'Rakoto', email: 'jean.rakoto@univ.mg' },
    semester: { id: 1, name: 'S1' },
    track: null,
    grades: [
      {
        subject: { id: 1, code: 'INF101', name: 'Programmation procédurale', credits: 7, type: 'Obligatoire' },
        grade: 15.5
      },
      {
        subject: { id: 2, code: 'INF104', name: 'HTML et Introduction au Web', credits: 5, type: 'Obligatoire' },
        grade: 14.0
      },
      {
        subject: { id: 3, code: 'INF107', name: 'Informatique de Base', credits: 4, type: 'Obligatoire' },
        grade: 16.0
      },
      {
        subject: { id: 4, code: 'MTH101', name: 'Arithmétique et nombres', credits: 4, type: 'Obligatoire' },
        grade: 12.5
      },
      {
        subject: { id: 5, code: 'MTH102', name: 'Analyse mathématique', credits: 6, type: 'Obligatoire' },
        grade: 13.0
      },
      {
        subject: { id: 6, code: 'ORG101', name: 'Techniques de communication', credits: 4, type: 'Obligatoire' },
        grade: 14.5
      }
    ],
    summary: {
      totalCredits: 30,
      average: 14.25,
      passed: true
    }
  },
  '1-2': {
    student: { id: 1, firstName: 'Jean', lastName: 'Rakoto', email: 'jean.rakoto@univ.mg' },
    semester: { id: 2, name: 'S2' },
    track: null,
    grades: [
      {
        subject: { id: 7, code: 'INF102', name: 'Bases de données relationnelles', credits: 5, type: 'Obligatoire' },
        grade: 14.0
      },
      {
        subject: { id: 8, code: 'INF103', name: 'Bases de l\'administration système', credits: 5, type: 'Obligatoire' },
        grade: 13.5
      },
      {
        subject: { id: 9, code: 'INF105', name: 'Maintenance matériel et logiciel', credits: 4, type: 'Obligatoire' },
        grade: 12.5
      },
      {
        subject: { id: 10, code: 'INF106', name: 'Compléments de programmation', credits: 6, type: 'Obligatoire' },
        grade: 14.0
      },
      {
        subject: { id: 11, code: 'MTH103', name: 'Calcul Vectoriel et Matriciel', credits: 6, type: 'Obligatoire' },
        grade: 13.5
      },
      {
        subject: { id: 12, code: 'MTH105', name: 'Probabilité et Statistique', credits: 4, type: 'Obligatoire' },
        grade: 13.0
      }
    ],
    summary: {
      totalCredits: 30,
      average: 13.50,
      passed: true
    }
  },
  '1-3': {
    student: { id: 1, firstName: 'Jean', lastName: 'Rakoto', email: 'jean.rakoto@univ.mg' },
    semester: { id: 3, name: 'S3' },
    track: null,
    grades: [
      {
        subject: { id: 13, code: 'INF201', name: 'Programmation orientée objet', credits: 6, type: 'Obligatoire' },
        grade: 13.0
      },
      {
        subject: { id: 14, code: 'INF202', name: 'Bases de données objets', credits: 6, type: 'Obligatoire' },
        grade: 12.5
      },
      {
        subject: { id: 15, code: 'INF203', name: 'Programmation système', credits: 4, type: 'Obligatoire' },
        grade: 12.0
      },
      {
        subject: { id: 16, code: 'INF208', name: 'Réseaux informatiques', credits: 6, type: 'Obligatoire' },
        grade: 13.5
      },
      {
        subject: { id: 17, code: 'MTH201', name: 'Méthodes numériques', credits: 4, type: 'Obligatoire' },
        grade: 12.5
      },
      {
        subject: { id: 18, code: 'ORG201', name: 'Bases de gestion', credits: 4, type: 'Obligatoire' },
        grade: 13.0
      }
    ],
    summary: {
      totalCredits: 30,
      average: 12.75,
      passed: true
    }
  },
  '1-4': {
    student: { id: 1, firstName: 'Jean', lastName: 'Rakoto', email: 'jean.rakoto@univ.mg' },
    semester: { id: 4, name: 'S4' },
    track: { id: 1, name: 'Développement' },
    grades: [
      {
        subject: { id: 22, code: 'INF207', name: 'Eléments Algorithmique', credits: 6, type: 'Obligatoire' },
        grade: 13.5
      },
      {
        subject: { id: 23, code: 'INF210', name: 'Mini-projet de développement', credits: 10, type: 'Obligatoire' },
        grade: 14.5
      },
      {
        subject: { id: 20, code: 'INF205', name: 'Système d\'information', credits: 6, type: 'Optionnel' },
        grade: 13.0
      },
      {
        subject: { id: 24, code: 'MTH203', name: 'MAO', credits: 4, type: 'Obligatoire' },
        grade: 14.0
      },
      {
        subject: { id: 25, code: 'MTH204', name: 'Géométrie', credits: 4, type: 'Optionnel' },
        grade: 14.5
      }
    ],
    summary: {
      totalCredits: 30,
      average: 13.98,
      passed: true
    }
  }
}

const mockYearGrades = {
  '1-1': {
    student: {
      id: 1,
      firstName: 'Jean',
      lastName: 'Rakoto',
      email: 'jean.rakoto@univ.mg',
      birthDate: '2002-05-15'
    },
    semesters: [
      {
        semesterId: 1,
        semesterName: 'SEMESTRE 1',
        track: null,
        totalCredits: 30,
        average: 14.25,
        passed: true,
        grades: [
          {
            subject: { id: 1, code: 'INF101', name: 'Programmation procédurale', credits: 7, type: 'Obligatoire' },
            grade: 15.5
          },
          {
            subject: { id: 2, code: 'INF104', name: 'HTML et Introduction au Web', credits: 5, type: 'Obligatoire' },
            grade: 14.0
          },
          {
            subject: { id: 3, code: 'INF107', name: 'Informatique de Base', credits: 4, type: 'Obligatoire' },
            grade: 16.0
          },
          {
            subject: { id: 4, code: 'MTH101', name: 'Arithmétique et nombres', credits: 4, type: 'Obligatoire' },
            grade: 12.5
          },
          {
            subject: { id: 5, code: 'MTH102', name: 'Analyse mathématique', credits: 6, type: 'Obligatoire' },
            grade: 13.0
          },
          {
            subject: { id: 6, code: 'ORG101', name: 'Techniques de communication', credits: 4, type: 'Obligatoire' },
            grade: 14.5
          }
        ]
      },
      {
        semesterId: 2,
        semesterName: 'SEMESTRE 2',
        track: null,
        totalCredits: 30,
        average: 13.50,
        passed: true,
        grades: [
          {
            subject: { id: 7, code: 'INF102', name: 'Bases de données relationnelles', credits: 5, type: 'Obligatoire' },
            grade: 14.0
          },
          {
            subject: { id: 8, code: 'INF103', name: 'Bases de l\'administration système', credits: 5, type: 'Obligatoire' },
            grade: 13.5
          },
          {
            subject: { id: 9, code: 'INF105', name: 'Maintenance matériel et logiciel', credits: 4, type: 'Obligatoire' },
            grade: 12.5
          },
          {
            subject: { id: 10, code: 'INF106', name: 'Compléments de programmation', credits: 6, type: 'Obligatoire' },
            grade: 14.0
          },
          {
            subject: { id: 11, code: 'MTH103', name: 'Calcul Vectoriel et Matriciel', credits: 6, type: 'Obligatoire' },
            grade: 13.5
          },
          {
            subject: { id: 12, code: 'MTH105', name: 'Probabilité et Statistique', credits: 4, type: 'Obligatoire' },
            grade: 13.0
          }
        ]
      }
    ],
    summary: {
      totalCredits: 60,
      average: 13.88,
      passed: true
    }
  },
  '1-2': {
    student: {
      id: 1,
      firstName: 'Jean',
      lastName: 'Rakoto',
      email: 'jean.rakoto@univ.mg',
      birthDate: '2002-05-15'
    },
    semesters: [
      {
        semesterId: 3,
        semesterName: 'SEMESTRE 3',
        track: null,
        totalCredits: 30,
        average: 12.75,
        passed: true,
        grades: [
          {
            subject: { id: 13, code: 'INF201', name: 'Programmation orientée objet', credits: 6, type: 'Obligatoire' },
            grade: 13.0
          },
          {
            subject: { id: 14, code: 'INF202', name: 'Bases de données objets', credits: 6, type: 'Obligatoire' },
            grade: 12.5
          },
          {
            subject: { id: 15, code: 'INF203', name: 'Programmation système', credits: 4, type: 'Obligatoire' },
            grade: 12.0
          },
          {
            subject: { id: 16, code: 'INF208', name: 'Réseaux informatiques', credits: 6, type: 'Obligatoire' },
            grade: 13.5
          },
          {
            subject: { id: 17, code: 'MTH201', name: 'Méthodes numériques', credits: 4, type: 'Obligatoire' },
            grade: 12.5
          },
          {
            subject: { id: 18, code: 'ORG201', name: 'Bases de gestion', credits: 4, type: 'Obligatoire' },
            grade: 13.0
          }
        ]
      },
      {
        semesterId: 4,
        semesterName: 'SEMESTRE 4',
        track: { id: 1, name: 'Développement' },
        totalCredits: 30,
        average: 13.98,
        passed: true,
        grades: [
          {
            subject: { id: 22, code: 'INF207', name: 'Eléments Algorithmique', credits: 6, type: 'Obligatoire' },
            grade: 13.5
          },
          {
            subject: { id: 23, code: 'INF210', name: 'Mini-projet de développement', credits: 10, type: 'Obligatoire' },
            grade: 14.5
          },
          {
            subject: { id: 20, code: 'INF205', name: 'Système d\'information', credits: 6, type: 'Optionnel' },
            grade: 13.0
          },
          {
            subject: { id: 24, code: 'MTH203', name: 'MAO', credits: 4, type: 'Obligatoire' },
            grade: 14.0
          },
          {
            subject: { id: 25, code: 'MTH204', name: 'Géométrie', credits: 4, type: 'Optionnel' },
            grade: 14.5
          }
        ]
      }
    ],
    summary: {
      totalCredits: 60,
      average: 13.37,
      passed: true
    }
  }
}

export {
  mockUsers,
  mockStudents,
  mockSemesters,
  mockParcours,
  mockStudentAverages,
  mockStudentDetails,
  mockSemesterGrades,
  mockYearGrades
}
