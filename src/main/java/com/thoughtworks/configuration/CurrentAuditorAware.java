package com.thoughtworks.configuration;

import com.thoughtworks.common.CurrentUser;
import org.apache.commons.lang3.StringUtils;
import org.springframework.data.domain.AuditorAware;
import org.springframework.stereotype.Component;

@Component
public class CurrentAuditorAware implements AuditorAware {

    public static final String SYS_DEFAULT_USER = "superAdmin";

    @Override
    public String getCurrentAuditor() {
        String username = CurrentUser.getUsername();
        if(StringUtils.isNotBlank(username)) {
            return username;
        }
        return SYS_DEFAULT_USER;
    }
}
