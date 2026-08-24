package com.chirru.portfolio.service;

import com.chirru.portfolio.dto.admin.*;
import com.chirru.portfolio.entity.*;
import com.chirru.portfolio.repository.*;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.server.ResponseStatusException;

import java.util.HashSet;
import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional
public class AdminPortfolioService {
    private final ProfileRepository profileRepository;
    private final ProjectRepository projectRepository;
    private final SkillRepository skillRepository;
    private final ExperienceRepository experienceRepository;
    private final EducationRepository educationRepository;
    private final CertificationRepository certificationRepository;
    private final MessageRepository messageRepository;

    @Transactional(readOnly = true)
    public Profile getProfile() {
        return profileRepository.findAll().stream().findFirst()
                .orElseThrow(() -> notFound("Profile not configured"));
    }

    public Profile saveProfile(ProfileRequest request) {
        Profile profile = profileRepository.findAll().stream().findFirst().orElseGet(Profile::new);
        profile.setName(request.name());
        profile.setHeadline(request.headline());
        profile.setBio(request.bio());
        profile.setEmail(request.email());
        profile.setPhone(request.phone());
        profile.setLocation(request.location());
        profile.setGithubUrl(request.githubUrl());
        profile.setLinkedinUrl(request.linkedinUrl());
        profile.setResumeUrl(request.resumeUrl());
        profile.setImageUrl(request.imageUrl());
        return profileRepository.save(profile);
    }

    @Transactional(readOnly = true)
    public List<Project> projects() { return projectRepository.findAllByOrderByDisplayOrderAsc(); }

    public Project createProject(ProjectRequest request) {
        Project project = new Project();
        apply(project, request);
        return projectRepository.save(project);
    }

    public Project updateProject(Long id, ProjectRequest request) {
        Project project = requireProject(id);
        apply(project, request);
        return projectRepository.save(project);
    }

    public void deleteProject(Long id) { projectRepository.delete(requireProject(id)); }

    private void apply(Project project, ProjectRequest request) {
        project.setTitle(request.title());
        project.setSlug(request.slug());
        project.setDescription(request.description());
        project.setImageUrl(request.imageUrl());
        project.setGithubUrl(request.githubUrl());
        project.setLiveUrl(request.liveUrl());
        project.setFeatured(request.featured());
        project.setDisplayOrder(request.displayOrder());
        project.setSkills(new HashSet<>(skillRepository.findAllById(request.skillIds())));
    }

    @Transactional(readOnly = true)
    public List<Skill> skills() { return skillRepository.findAllByOrderByNameAsc(); }

    public Skill createSkill(SkillRequest request) {
        Skill skill = new Skill();
        apply(skill, request);
        return skillRepository.save(skill);
    }

    public Skill updateSkill(Long id, SkillRequest request) {
        Skill skill = requireSkill(id);
        apply(skill, request);
        return skillRepository.save(skill);
    }

    public void deleteSkill(Long id) { skillRepository.delete(requireSkill(id)); }

    private void apply(Skill skill, SkillRequest request) {
        skill.setName(request.name());
        skill.setCategory(request.category());
        skill.setIcon(request.icon());
    }

    @Transactional(readOnly = true)
    public List<Experience> experience() { return experienceRepository.findAllByOrderByDisplayOrderAscStartDateDesc(); }

    public Experience createExperience(ExperienceRequest request) {
        Experience experience = new Experience();
        apply(experience, request);
        return experienceRepository.save(experience);
    }

    public Experience updateExperience(Long id, ExperienceRequest request) {
        Experience experience = requireExperience(id);
        apply(experience, request);
        return experienceRepository.save(experience);
    }

    public void deleteExperience(Long id) { experienceRepository.delete(requireExperience(id)); }

    private void apply(Experience experience, ExperienceRequest request) {
        experience.setCompany(request.company());
        experience.setPosition(request.position());
        experience.setDescription(request.description());
        experience.setStartDate(request.startDate());
        experience.setEndDate(request.endDate());
        experience.setCurrent(request.current());
        experience.setDisplayOrder(request.displayOrder());
    }

    @Transactional(readOnly = true)
    public List<Education> education() { return educationRepository.findAllByOrderByDisplayOrderAscStartDateDesc(); }

    public Education createEducation(EducationRequest request) {
        Education education = new Education();
        apply(education, request);
        return educationRepository.save(education);
    }

    public Education updateEducation(Long id, EducationRequest request) {
        Education education = requireEducation(id);
        apply(education, request);
        return educationRepository.save(education);
    }

    public void deleteEducation(Long id) { educationRepository.delete(requireEducation(id)); }

    private void apply(Education education, EducationRequest request) {
        education.setInstitution(request.institution());
        education.setDegree(request.degree());
        education.setField(request.field());
        education.setDescription(request.description());
        education.setStartDate(request.startDate());
        education.setEndDate(request.endDate());
        education.setDisplayOrder(request.displayOrder());
    }

    @Transactional(readOnly = true)
    public List<Certification> certifications() { return certificationRepository.findAllByOrderByDisplayOrderAscIssueDateDesc(); }

    public Certification createCertification(CertificationRequest request) {
        Certification certification = new Certification();
        apply(certification, request);
        return certificationRepository.save(certification);
    }

    public Certification updateCertification(Long id, CertificationRequest request) {
        Certification certification = requireCertification(id);
        apply(certification, request);
        return certificationRepository.save(certification);
    }

    public void deleteCertification(Long id) { certificationRepository.delete(requireCertification(id)); }

    private void apply(Certification certification, CertificationRequest request) {
        certification.setName(request.name());
        certification.setIssuer(request.issuer());
        certification.setIssueDate(request.issueDate());
        certification.setCredentialUrl(request.credentialUrl());
        certification.setImageUrl(request.imageUrl());
        certification.setDisplayOrder(request.displayOrder());
    }

    @Transactional(readOnly = true)
    public List<Message> messages() { return messageRepository.findAllByOrderByCreatedAtDesc(); }

    public Message updateMessageStatus(Long id, boolean read) {
        Message message = requireMessage(id);
        message.setRead(read);
        return messageRepository.save(message);
    }

    public void deleteMessage(Long id) { messageRepository.delete(requireMessage(id)); }

    @Transactional(readOnly = true)
    public long unreadMessages() { return messageRepository.countByReadFalse(); }

    private Project requireProject(Long id) { return projectRepository.findById(id).orElseThrow(() -> notFound("Project not found")); }
    private Skill requireSkill(Long id) { return skillRepository.findById(id).orElseThrow(() -> notFound("Skill not found")); }
    private Experience requireExperience(Long id) { return experienceRepository.findById(id).orElseThrow(() -> notFound("Experience not found")); }
    private Education requireEducation(Long id) { return educationRepository.findById(id).orElseThrow(() -> notFound("Education not found")); }
    private Certification requireCertification(Long id) { return certificationRepository.findById(id).orElseThrow(() -> notFound("Certification not found")); }
    private Message requireMessage(Long id) { return messageRepository.findById(id).orElseThrow(() -> notFound("Message not found")); }
    private ResponseStatusException notFound(String message) { return new ResponseStatusException(HttpStatus.NOT_FOUND, message); }
}
