import { BadgeCheck } from 'lucide-react'
import { adminApi } from '../api'
import ContentList from './ContentList'

export default function Certifications() {
  return (
    <ContentList
      title="Certifications"
      subtitle="Showcase your professional accreditations, verified badges, and certifications."
      icon={BadgeCheck}
      queryKey="certifications"
      queryFn={adminApi.certifications}
      createFn={adminApi.createCertification}
      deleteFn={adminApi.deleteCertification}
      formFields={[
        {
          name: 'name',
          label: 'Certificate Title',
          placeholder: 'e.g. AWS Certified Solutions Architect',
          required: true,
        },
        {
          name: 'issuer',
          label: 'Issuing Organization',
          placeholder: 'e.g. Amazon Web Services (AWS)',
          required: true,
        },
        {
          name: 'issueDate',
          label: 'Issue Date / Year',
          placeholder: 'e.g. 2024',
          required: false,
        },
        {
          name: 'credentialUrl',
          label: 'Verification URL (Optional)',
          type: 'url',
          placeholder: 'https://www.credly.com/...',
          required: false,
        },
      ]}
      displayPrimary={(item) => item.name || item.title}
      displaySecondary={(item) => item.issuer || item.organization}
      displayExtra={(item) => item.issueDate || item.year}
    />
  )
}