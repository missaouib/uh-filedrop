package edu.hawaii.its.filedrop.controller;

import java.time.temporal.ChronoUnit;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.flowable.task.api.Task;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.multipart.MultipartFile;

import edu.hawaii.its.filedrop.access.UserContextService;
import edu.hawaii.its.filedrop.repository.FileSetRepository;
import edu.hawaii.its.filedrop.service.FileDropService;
import edu.hawaii.its.filedrop.service.LdapService;
import edu.hawaii.its.filedrop.type.FileDrop;
import edu.hawaii.its.filedrop.type.FileSet;

@Controller
public class PrepareController {

    private Log logger = LogFactory.getLog(PrepareController.class);

    @Autowired
    private UserContextService userContextService;

    @Autowired
    private FileDropService fileDropService;

    @Autowired
    private FileSetRepository fileSetRepository;

    @Autowired
    private LdapService ldapService;

    @Value("${app.max.size}")
    private String maxUploadSize;

    @PreAuthorize("hasRole('UH')")
    @PostMapping(value = "/prepare")
    public String addRecipients(@RequestParam("validation") Boolean validation,
            @RequestParam("expiration") Integer expiration,
            @RequestParam("recipients") String[] recipients) {
        logger.debug("User added recipient.");
        //        LdapPerson ldapPerson = ldapService.findByUid(recipient);
        FileDrop fileDrop = new FileDrop();
        fileDropService.saveFileDrop(fileDrop);
        fileDrop.setRecipient(Arrays.toString(recipients));
        fileDrop.setEncryptionKey("test-enc-key-" + fileDrop.getId());
        fileDrop.setDownloadKey("test-dl-key-" + fileDrop.getId());
        fileDrop.setUploadKey("test-ul-key-" + fileDrop.getId());
        fileDrop.setUploader(userContextService.getCurrentUhuuid());
        fileDrop.setUploaderFullName(userContextService.getCurrentUser().getName());
        fileDrop.setCreated(new Date());
        fileDrop.setExpiration(Date.from(fileDrop.getCreated().toInstant().plus(expiration, ChronoUnit.DAYS)));
        fileDrop.setValid(validation);
        fileDrop.setAuthenticationRequired(validation);
        fileDropService.saveFileDrop(fileDrop);
        fileDropService.addRecipients(userContextService.getCurrentUser(), recipients);
        Map<String, Object> args = new HashMap<>();
        args.put("fileDropId", fileDrop.getId());
        fileDropService.addProcessVariables(
                fileDropService.getCurrentTask(userContextService.getCurrentUser()).getProcessInstanceId(), args);
        logger.debug(userContextService.getCurrentUser().getUsername() + " created new " + fileDrop);
        return "redirect:/prepare/files";
    }

    @PreAuthorize("hasRole('UH')")
    @GetMapping(value = "/prepare/files")
    public String addFiles(Model model) {
        Task currentTask = fileDropService.getCurrentTask(userContextService.getCurrentUser());
        if (currentTask.getName().equalsIgnoreCase("addRecipients")) {
            return "redirect:/prepare";
        }
        logger.debug("User at addFiles.");
        model.addAttribute("recipients",
                fileDropService.getProcessVariables(currentTask.getProcessInstanceId()).get("recipients"));
        model.addAttribute("maxUploadSize", maxUploadSize);
        return "user/files";
    }

    @PreAuthorize("hasRole('UH')")
    @PostMapping(value = "/prepare/files")
    @ResponseStatus(value = HttpStatus.OK)
    public void uploadFiles(@RequestParam("file") MultipartFile file,
            @RequestParam("comment") String comment) {
        FileSet fileSet = new FileSet();
        fileSet.setFileName(file.getOriginalFilename());
        fileSet.setType(file.getContentType());
        fileSet.setComment(comment);
        Map<String, Object> args = fileDropService.getProcessVariables(
                fileDropService.getCurrentTask(userContextService.getCurrentUser()).getProcessInstanceId());
        fileSet.setFileDrop(fileDropService.getFileDrop((Integer) args.get("fileDropId")));
        fileDropService.saveFileSet(fileSet);
        logger.debug(userContextService.getCurrentUser().getUsername() + " uploaded: " + fileSet);
    }
}
